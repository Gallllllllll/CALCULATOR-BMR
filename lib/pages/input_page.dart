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
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.male;
  int height = 160;
  int weight = 60;
  int age = 20;
  String activityLevel = 'Sedentary';

  final List<String> activityOptions = [
    'Sedentary',
    'Aktivitas ringan',
    'Aktivitas menengah',
    'Aktivitas berat',
    'Aktivitas ekstrim',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR & KALORI CALCULATOR'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gender
              Row(
                children: [
                  Expanded(
                    child: CustomCard(
                      color: selectedGender == Gender.male
                          ? activeCardColor
                          : inactiveCardColor,
                      cardChild: IconCard(
                        cardIcon: FontAwesomeIcons.mars,
                        caption: 'PRIA',
                      ),
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomCard(
                      color: selectedGender == Gender.female
                          ? activeCardColor
                          : inactiveCardColor,
                      cardChild: IconCard(
                        cardIcon: FontAwesomeIcons.venus,
                        caption: 'WANITA',
                      ),
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Height
              SizedBox(
                height: 180,
                child: CustomCard(
                  color: activeCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('TINGGI BADAN', style: labelTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(height.toString(), style: numberTextStyle),
                          const Text('cm', style: labelTextStyle),
                        ],
                      ),
                      Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double value) {
                          setState(() {
                            height = value.round();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Weight & Age
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 180,
                      child: CustomCard(
                        color: activeCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('BERAT BADAN', style: labelTextStyle),
                            Text(weight.toString(), style: numberTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      if (weight > 1) weight--;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 180,
                      child: CustomCard(
                        color: activeCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('UMUR', style: labelTextStyle),
                            Text(age.toString(), style: numberTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      if (age > 1) age--;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Activity level
              SizedBox(
                height: 120,
                child: CustomCard(
                  color: activeCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('AKTIVITAS HARIAN', style: labelTextStyle),
                      DropdownButton<String>(
                        value: activityLevel,
                        dropdownColor: const Color(0xFF1D1E33),
                        items: activityOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            activityLevel = newValue ?? 'Sedentary';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Calculate Button
              BottomButton(
                buttonTitle: 'HITUNG BMR',
                onTap: () {
                  CalculatorBMR calc = CalculatorBMR(
                    height: height,
                    weight: weight,
                    age: age,
                    gender: selectedGender,
                    activityLevel: activityLevel,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        result: 'BMR & Kalori Harian',
                        bmi: calc.calculateBMR().toStringAsFixed(0),
                        information:
                            'Kebutuhan kalori harian (TDEE): ${calc.calculateTDEE().toStringAsFixed(0)} kkal',
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
