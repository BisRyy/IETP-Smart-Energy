import 'package:smart_home/feature/smart_home/domain/entities/pump.dart';

class PumpModel extends Pump {
  const PumpModel({
    required bool pump1,
    required bool pump2,
    required bool pump3,
  }) : super(
          pump1: pump1,
          pump2: pump2,
          pump3: pump3,
        );

  factory PumpModel.fromJson(Map<String, dynamic> json) {
    return PumpModel(
      pump1: json['pump1'],
      pump2: json['pump2'],
      pump3: json['pump3'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pump1': pump1,
      'pump2': pump2,
      'pump3': pump3,
    };
  }
}
