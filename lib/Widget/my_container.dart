import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/calculator_cubit.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    this.buttonColor,
    required this.shadowColor,
    required this.text,
    this.textColor,
    required this.onTap,
  });
  final Color? buttonColor;
  final Color shadowColor;
  final String text;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
        listener: (context, state) {},
        builder: (context, state) {
          CalculatorCubit calculatorCubit = CalculatorCubit.get(context);
          return InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Ink(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  color: buttonColor ?? Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: calculatorCubit.shadowColor,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(3, 3))
                  ]),
              child: Center(
                  child: Text(text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: textColor ?? Colors.blueAccent))),
            ),
          );
        });
  }
}
