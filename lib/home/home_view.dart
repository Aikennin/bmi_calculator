import 'package:flutter/material.dart';

import '../widgets/button_navigatton.dart';
import '../widgets/gender_card.dart';
import '../widgets/height_card.dart';
import '../widgets/revome_add.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isMale = false;
  double height = 180;
  double weight = 60;
  int age = 28;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff211834),
      appBar: AppBar(
        backgroundColor: const Color(0xff211834),
        title: const Text('BMI CALCULATOR'),
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 15, 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GenderCard(
                      icon: Icons.male,
                      text: 'MALE',
                      isActive: isMale,
                      onTap: () {
                        isMale = true;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: GenderCard(
                      icon: Icons.female,
                      text: 'FEMALE',
                      isActive: !isMale,
                      onTap: () {
                        isMale = false;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              HeightCard(
                value: height,
                onChanged: (v) {
                  height = v;
                  setState(() {});
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: RemoveAddCard(
                      text: 'WEIGHT',
                      value: weight,
                      onPressedRemove: () {
                        weight--;
                        setState(() {});
                      },
                      onPressedAdd: () {
                        weight++;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: RemoveAddCard(
                      text: 'AGE',
                      value: age.toDouble(),
                      onPressedRemove: () {
                        age--;
                        setState(() {});
                      },
                      onPressedAdd: () {
                        age++;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
        text: 'CALCULATE',
        onPressed: () {
          final bmi = calculate();
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                backgroundColor: const Color(0xff0B0120),
                title: Center(
                  child: Text(
                    bmi.$1,
                    style: TextStyle(
                      fontSize: 30,
                      color: bmi.$4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                content: Text(
                  '${bmi.$2}',
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Text(
                    bmi.$3,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  (String, double, String, Color) calculate() {
    final v = weight / ((height * height) / 10000);
    final result = double.parse(v.toStringAsFixed(1));

    if (result < 18.5) {
      final x = 20 * ((height * height) / 10000);
      final y = x - weight;
      return (
        "Вы худая",
        result,
        "вы худая,нужно работать над собой,${y.roundToDouble()}прибавьте вес",
        Colors.red,
      );
    } else if (result >= 18.5 && result < 25) {
      return (
        "Нормальный вес",
        result,
        "Ваш вес идиален!",
        Colors.green,
      );
    } else {
      final x = 24 * ((height * height) / 10000);
      final y = weight - x;
      return (
        "вы полная",
        result,
        "ваш вес больше чем оно должно быть,${y.roundToDouble()} нужно привести себя в форму",
        Colors.red,
      );
    }
  }
}
