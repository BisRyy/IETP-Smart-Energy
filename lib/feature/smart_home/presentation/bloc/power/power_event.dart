part of 'power_bloc.dart';

sealed class PowerEvent extends Equatable {
  const PowerEvent();

  @override
  List<Object> get props => [];
}

class GetPowerEvent extends PowerEvent {
  const GetPowerEvent();
}

class GetPumpEvent extends PowerEvent {
  const GetPumpEvent();
}

class SetPumpEvent extends PowerEvent {
  const SetPumpEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
