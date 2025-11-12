import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bmi/components/custom_card.dart';
import 'package:flutter_bmi/components/icon_card.dart';
import 'package:flutter_bmi/constan.dart';
import 'package:flutter_bmi/components/bottom_button.dart';
import 'package:flutter_bmi/components/round_icon_button.dart';
import 'package:flutter_bmi/pages/calculator_bmr.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 153;
  int weight = 37;
  int age = 37;
  String activityLevel = 'Sedentary';

  final List<String> activityLevels = [
    'Sedentary',
    'Aktivitas ringan',
    'Aktivitas menengah',
    'Aktivitas berat',
    'Aktivitas ekstrim',
  ];

  @override
  Widget build(BuildContext context) {
    const brownColor = Color(0xFF5A2E0F);
    const orangeColor = Color(0xFFFF7A00);
    const yellowColor = Color(0xFFFEC020);
    const bgColor = Color(0xFFFFF5E0);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'BMR & Calorie Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: brownColor,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // ===== Gender Selection =====
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Gender', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedGender = Gender.male),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: selectedGender == Gender.male ? orangeColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: brownColor, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.male, size: 50, color: brownColor),
                            Text('MAN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brownColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedGender = Gender.female),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: selectedGender == Gender.female ? orangeColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: brownColor, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.female, size: 50, color: brownColor),
                            Text('WOMAN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brownColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              // ===== Height =====
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Height adjust', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: brownColor)),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: brownColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        color: yellowColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Height',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$height CM',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: height.toDouble(),
                      min: 100,
                      max: 220,
                      activeColor: yellowColor,
                      inactiveColor: Colors.white30,
                      onChanged: (val) => setState(() => height = val.round()),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              // ===== Weight & Age =====
              Row(
                children: [
                  Expanded(
                    child: _buildInputBox(
                      title: 'Weight',
                      value: weight,
                      onMinus: () => setState(() {
                        if (weight > 1) weight--;
                      }),
                      onPlus: () => setState(() => weight++),
                      color: orangeColor,
                      textColor: brownColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildInputBox(
                      title: 'Age',
                      value: age,
                      onMinus: () => setState(() {
                        if (age > 1) age--;
                      }),
                      onPlus: () => setState(() => age++),
                      color: orangeColor,
                      textColor: brownColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              // ===== Activity Level =====
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Daily Activities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: brownColor)),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: brownColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  dropdownColor: brownColor,
                  value: activityLevel,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: (value) => setState(() => activityLevel = value!),
                  items: activityLevels
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(level, style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 30),
              // ===== Calculate Button =====
              GestureDetector(
                onTap: () {
                  CalculatorBMR calc = CalculatorBMR(
                    height: height,
                    weight: weight,
                    age: age,
                    gender: selectedGender ?? Gender.male,
                    activityLevel: activityLevel,
                  );
                  final bmr = calc.calculateBMR();
                  final tdee = calc.calculateTDEE();

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: brownColor,
                      title: const Text('Hasil Perhitungan', style: TextStyle(color: Colors.white)),
                      content: Text(
                        'BMR kamu: ${bmr.toStringAsFixed(2)}\nTDEE kamu: ${tdee.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: yellowColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'Calculation',
                      style: TextStyle(
                        color: Color(0xFF5A2E0F),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputBox({
  required String title,
  required int value,
  required VoidCallback onMinus,
  required VoidCallback onPlus,
  required Color color,
  required Color textColor,
}) {
  const brownCircle = Color(0xFF5A2E0F); // warna coklat kontras

  return Container(
    height: 140,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        ),
        const SizedBox(height: 5),
        Text(
          '$value',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tombol minus
            GestureDetector(
              onTap: onMinus,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: brownCircle,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.remove, color: Colors.white),
              ),
            ),
            const SizedBox(width: 15),
            // Tombol plus
            GestureDetector(
              onTap: onPlus,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: brownCircle,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}
