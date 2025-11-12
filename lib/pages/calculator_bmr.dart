import 'package:flutter_bmi/constan.dart';

class CalculatorBMR {
  final int height;
  final int weight;
  final int age;
  final Gender gender;
  final String activityLevel;

  CalculatorBMR({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.activityLevel,
  });

  // Hitung BMR
  double calculateBMR() {
    if (gender == Gender.male) {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  // Hitung TDEE
  double calculateTDEE() {
    double multiplier = 1.2;
    switch (activityLevel) {
      case 'Sedentary':
        multiplier = 1.2;
        break;
      case 'Aktivitas ringan':
        multiplier = 1.375;
        break;
      case 'Aktivitas menengah':
        multiplier = 1.55;
        break;
      case 'Aktivitas berat':
        multiplier = 1.725;
        break;
      case 'Aktivitas ekstrim':
        multiplier = 1.9;
        break;
    }
    return calculateBMR() * multiplier;
  }
}
