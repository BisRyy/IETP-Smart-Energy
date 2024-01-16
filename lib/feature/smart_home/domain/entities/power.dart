import 'package:equatable/equatable.dart';

class Power extends Equatable {
  final double power;
  final double moisture;
  final double water;

  const Power({
    this.power = 0,
    this.moisture = 0,
    this.water = 0,
  });

  @override
  List<Object?> get props => [power, moisture, water];
}
