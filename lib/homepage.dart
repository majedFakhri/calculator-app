import 'package:calculator/cubit/calculator_cubit.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Widget/my_container.dart';
import 'core/enums.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
      listener: (context, state) {},
      builder: (context, state) {
        CalculatorCubit calculatorCubit = CalculatorCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: calculatorCubit.buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              title: const Text('Calculator',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.blueAccent,
                      fontFamily: 'BackToSchool')),
              centerTitle: true,
              actions: [
                IconButton(
                    color: Colors.blueAccent,
                    icon: calculatorCubit.icon,
                    onPressed: () {
                      calculatorCubit.theme();
                    }),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(calculatorCubit.operation,
                            style: const TextStyle(
                                fontSize: 40, color: Colors.blueAccent)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(calculatorCubit.resultSize(),
                            style: TextStyle(
                                fontWeight: calculatorCubit.resultWeight,
                                fontSize: calculatorCubit.resultTextSize,
                                color: Colors.blueAccent)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyContainer(
                          text: "C",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () async {
                            await calculatorCubit.clear();
                          },
                        ),
                        MyContainer(
                          text: "±",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () async {
                            calculatorCubit.pOrN();
                          },
                        ),
                        MyContainer(
                          text: "%",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () {
                            if (calculatorCubit.operation.isNotEmpty) {
                              calculatorCubit.mathInOperation('%');
                            }

                            calculatorCubit.operationEnum =
                                OperationEnum.division100;
                            calculatorCubit.math();
                          },
                        ),
                        MyContainer(
                          text: "/",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () {
                            calculatorCubit.mathInOperation('/');
                            calculatorCubit.operationEnum =
                                OperationEnum.division;
                            if (calculatorCubit.secondNumber != null) {
                              calculatorCubit.firstNumber =
                                  calculatorCubit.result;
                              calculatorCubit.result = 0;
                              calculatorCubit.secondNumber = null;
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyContainer(
                          text: "1",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "1";
                            if (calculatorCubit.operationEnum ==
                                    OperationEnum.nul ||
                                calculatorCubit.operationEnum ==
                                    OperationEnum.division100) {
                              calculatorCubit.addToFirstNumber(1);
                            } else {
                              calculatorCubit.addToSecondNumber(1);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "2",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "2";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(2);
                            } else {
                              calculatorCubit.addToSecondNumber(2);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "3",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "3";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(3);
                            } else {
                              calculatorCubit.addToSecondNumber(3);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "*",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () {
                            calculatorCubit.mathInOperation('*');

                            calculatorCubit.operationEnum =
                                OperationEnum.multiply;
                            if (calculatorCubit.secondNumber != null) {
                              calculatorCubit.firstNumber =
                                  calculatorCubit.result;
                              calculatorCubit.result = 0;
                              calculatorCubit.secondNumber = null;
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyContainer(
                          text: "4",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "4";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(4);
                            } else {
                              calculatorCubit.addToSecondNumber(4);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "5",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "5";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(5);
                            } else {
                              calculatorCubit.addToSecondNumber(5);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "6",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "6";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(6);
                            } else {
                              calculatorCubit.addToSecondNumber(6);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "-",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () {
                            calculatorCubit.mathInOperation('-');

                            calculatorCubit.operationEnum =
                                OperationEnum.subtract;
                            if (calculatorCubit.secondNumber != null) {
                              calculatorCubit.firstNumber =
                                  calculatorCubit.result;
                              calculatorCubit.result = 0;
                              calculatorCubit.secondNumber = null;
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyContainer(
                          text: "7",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "7";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(7);
                            } else {
                              calculatorCubit.addToSecondNumber(7);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "8",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "8";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(8);
                            } else {
                              calculatorCubit.addToSecondNumber(8);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "9",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            calculatorCubit.operation += "9";
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.addToFirstNumber(9);
                            } else {
                              calculatorCubit.addToSecondNumber(9);
                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: "+",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () {
                            calculatorCubit.mathInOperation('+');

                            calculatorCubit.operationEnum = OperationEnum.sum;
                            if (calculatorCubit.secondNumber != null) {
                              calculatorCubit.firstNumber =
                                  calculatorCubit.result;
                              calculatorCubit.result = 0;
                              calculatorCubit.secondNumber = null;
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyContainer(
                          text: "",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () {},
                        ),
                        MyContainer(
                          text: "0",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () async {
                            if (calculatorCubit.operationEnum ==
                                    OperationEnum.nul &&
                                calculatorCubit.firstNumber != null) {
                              calculatorCubit.firstNumber =
                                  calculatorCubit.firstNumber! * 10;
                              calculatorCubit.addZero();
                              calculatorCubit.firstNumberCount++;
                            } else if (calculatorCubit.secondNumber != null) {
                              calculatorCubit.secondNumber =
                                  calculatorCubit.secondNumber! * 10;
                              calculatorCubit.addZero();
                              calculatorCubit.secondNumberCount++;

                              await calculatorCubit.math();
                            }
                          },
                        ),
                        MyContainer(
                          text: ".",
                          shadowColor: Colors.grey,
                          buttonColor: calculatorCubit.buttonColor,
                          textColor: Colors.blueAccent,
                          onTap: () {
                            calculatorCubit.addPoint();
                            if (calculatorCubit.operationEnum ==
                                OperationEnum.nul) {
                              calculatorCubit.doubleNum1 =
                                  DoubleNum1Enum.doubleNum;
                              calculatorCubit.firstNumberCount++;
                            } else {
                              calculatorCubit.doubleNum2 =
                                  DoubleNum2Enum.doubleNum;
                              calculatorCubit.secondNumberCount++;
                            }
                          },
                        ),
                        MyContainer(
                          text: "=",
                          shadowColor: Colors.grey,
                          textColor: calculatorCubit.textColor,
                          onTap: () async {
                            calculatorCubit.resultStyle();
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
