import 'package:equatable/equatable.dart';

class Pump extends Equatable {
  final bool pump1;
  final bool pump2;
  final bool pump3;

  const Pump({
    this.pump1 = false,
    this.pump2 = false,
    this.pump3 = false,
  });

  @override
  List<Object?> get props => [pump1, pump2, pump3];
}
