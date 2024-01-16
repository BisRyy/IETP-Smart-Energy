import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_home/core/use_cases/usecase.dart';
import 'package:smart_home/feature/smart_home/domain/entities/power.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/power/set_pump.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/power/view_power.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/power/view_pump.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain/entities/pump.dart';

part 'power_event.dart';
part 'power_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PowerBloc extends Bloc<PowerEvent, PowerState> {
  final ViewPower viewPower;
  final ViewPump viewPump;
  final SetPump setPump;

  PowerBloc({
    required this.viewPower,
    required this.viewPump,
    required this.setPump,
  }) : super(const PowerState()) {
    on<GetPowerEvent>(_onPowerGetEvent,
        transformer: throttleDroppable(throttleDuration));
    on<GetPumpEvent>(_onPumpGetEvent,
        transformer: throttleDroppable(throttleDuration));
    on<SetPumpEvent>(_onPumpSetEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPowerGetEvent(
      GetPowerEvent event, Emitter<PowerState> emit) async {
    emit(state.copyWith(powerStatus: PowerStatus.loading));
    final result = await viewPower(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(powerStatus: PowerStatus.failure)),
      (power) => emit(state.copyWith(
        powerStatus: PowerStatus.success,
        power: power,
      )),
    );
  }

  Future<void> _onPumpGetEvent(
      GetPumpEvent event, Emitter<PowerState> emit) async {
    emit(state.copyWith(pumpStatus: PumpStatus.loading));
    final result = await viewPump(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(pumpStatus: PumpStatus.failure)),
      (pump) => emit(state.copyWith(
        pumpStatus: PumpStatus.success,
        pump: pump,
      )),
    );
  }

  Future<void> _onPumpSetEvent(
      SetPumpEvent event, Emitter<PowerState> emit) async {
    emit(state.copyWith(pumpStatus: PumpStatus.loading));
    final result = await setPump(Params(pump: event.id));

    result.fold(
      (failure) => emit(state.copyWith(pumpStatus: PumpStatus.failure)),
      (pump) => emit(state.copyWith(
        pumpStatus: PumpStatus.success,
        pump: pump,
      )),
    );
  }
}
