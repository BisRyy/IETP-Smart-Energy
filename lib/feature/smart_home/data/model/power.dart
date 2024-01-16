import '../../domain/entities/power.dart';

class PowerModel extends Power {
  const PowerModel({
    required double power,
    required double moisture,
    required double water,
  }) : super(
          power: power,
          moisture: moisture,
          water: water,
        );

  factory PowerModel.fromJson(Map<String, dynamic> json) {
    return PowerModel(
      power: json['power'].toDouble(),
      moisture: json['moisture'].toDouble(),
      water: json['water'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'power': power,
      'moisture': moisture,
      'water': water,
    };
  }
}
