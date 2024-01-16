part of 'power_bloc.dart';

enum PowerStatus {
  initial,
  loading,
  success,
  failure,
}

enum PumpStatus {
  initial,
  loading,
  success,
  failure,
}

class PowerState extends Equatable {
  final PowerStatus powerStatus;
  final PumpStatus pumpStatus;
  final Power power;
  final Pump pump;

  const PowerState({
    this.powerStatus = PowerStatus.initial,
    this.pumpStatus = PumpStatus.initial,
    this.power = const Power(),
    this.pump = const Pump(),
  });

  @override
  List<Object> get props => [powerStatus, pumpStatus, power, pump];

  PowerState copyWith({
    PowerStatus? powerStatus,
    PumpStatus? pumpStatus,
    Power? power,
    Pump? pump,
  }) {
    return PowerState(
      powerStatus: powerStatus ?? this.powerStatus,
      pumpStatus: pumpStatus ?? this.pumpStatus,
      power: power ?? this.power,
      pump: pump ?? this.pump,
    );
  }
}

