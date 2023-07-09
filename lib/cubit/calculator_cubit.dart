import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/enums.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit(this.sharedPreferences) : super(CalculatorInitial());
  static CalculatorCubit get(context) => BlocProvider.of(context);

  final SharedPreferences sharedPreferences;

  ThemeEnum? themeEnum = ThemeEnum.dark;
  Color buttonColor = Colors.white;
  Color shadowColor = Colors.grey;
  Color textColor = Colors.white;
  Icon icon = const Icon(Icons.nightlight_outlined);
  Color buttonOnTap = const Color.fromARGB(255, 29, 29, 29);

  OperationEnum? operationEnum = OperationEnum.nul;

  int firstNumberCount = 0;
  int secondNumberCount = 0;
  double? firstNumber;
  double? secondNumber;
  double result = 0;
  String operation = ' ';
  DoubleNum1Enum doubleNum1 = DoubleNum1Enum.normalNum1;
  DoubleNum2Enum doubleNum2 = DoubleNum2Enum.normalNum2;
  NumberPOrN numberPOrN = NumberPOrN.p;

  FontWeight resultWeight = FontWeight.normal;
  double resultTextSize = 50;

  Future<void> theme() async {
    if (themeEnum == ThemeEnum.dark) {
      themeEnum = ThemeEnum.light;
      buttonColor = Colors.white;
      shadowColor = Colors.grey;
      textColor = Colors.white;
      icon = const Icon(Icons.nightlight_outlined);
    } else {
      themeEnum = ThemeEnum.dark;
      buttonColor = const Color.fromARGB(255, 59, 59, 59);
      shadowColor = Colors.black;
      textColor = const Color.fromARGB(255, 59, 59, 59);
      icon = const Icon(Icons.sunny);
    }
    emit(RefreshTasksUIState());
  }

  Future<void> addToFirstNumber(double value) async {
    if (firstNumber == null) {
      firstNumber = value;
      firstNumberCount++;
    } else {
      firstNumber = firstNumber! * 10 + value;
      firstNumberCount++;
    }
    emit(RefreshTasksUIState());
  }

  Future<void> addToSecondNumber(double value) async {
    if (secondNumber == null) {
      secondNumber = value;
      secondNumberCount++;
    } else {
      secondNumber = secondNumber! * 10 + value;
      secondNumberCount++;
    }
    emit(RefreshTasksUIState());
  }

  Future<void> math() async {
    if (operationEnum != OperationEnum.nul && firstNumber == null) {
      firstNumber = 0;
    }
    if (doubleNum2 == DoubleNum2Enum.nul) {
      doubleNum2 = DoubleNum2Enum.normalNum2;
    }
    if (doubleNum1 == DoubleNum1Enum.doubleNum &&
        doubleNum2 == DoubleNum2Enum.normalNum2) {
      firstNumber = firstNumber! / 10;
    } else if (doubleNum2 == DoubleNum2Enum.doubleNum &&
        doubleNum1 != DoubleNum1Enum.doubleNum) {
      secondNumber = secondNumber! / 10;
    } else if (doubleNum2 == DoubleNum2Enum.doubleNum &&
        doubleNum1 == DoubleNum1Enum.doubleNum) {
      secondNumber = secondNumber! / 10;
    }
    if (operationEnum == OperationEnum.sum) {
      result = firstNumber! + secondNumber!;
    } else if (operationEnum == OperationEnum.subtract) {
      result = firstNumber! - secondNumber!;
    } else if (operationEnum == OperationEnum.division) {
      result = firstNumber! / secondNumber!;
    } else if (operationEnum == OperationEnum.multiply) {
      result = firstNumber! * secondNumber!;
    } else if (operationEnum == OperationEnum.division100 &&
        firstNumber != null) {
      result = firstNumber! / 100;
    }

    emit(RefreshTasksUIState());
  }

  Future<void> clear() async {
    firstNumber = null;
    secondNumber = null;
    result = 0;
    operation = ' ';
    operationEnum = OperationEnum.nul;
    doubleNum1 = DoubleNum1Enum.normalNum1;

    doubleNum2 = DoubleNum2Enum.nul;

    resultWeight = FontWeight.normal;
    resultTextSize = 50;
    emit(RefreshTasksUIState());
  }

  void resultStyle() {
    resultWeight = FontWeight.bold;
    resultTextSize = 60;
    emit(RefreshTasksUIState());
  }

  void pOrN() {
    var a = operation.split('');
    if (firstNumber != null && operationEnum == OperationEnum.nul) {
      firstNumber = firstNumber! * -1;
      if (a.first != '-') {
        a.insert(0, '-');
        operation = a.join();
      } else if (a.first == '-') {
        a.removeAt(0);
        operation = a.join();
      }
    } else if (secondNumber != null && operationEnum != OperationEnum.nul) {
      secondNumber = secondNumber! * -1;
      var s = secondNumberCount;
      while (s != 0) {
        a.removeLast();
        s--;
      }
      if (a.last != '-') {
        numberPOrN = NumberPOrN.p;
        a.add(secondNumber.toString());

        operation = a.join();
      } else if (a.last == '-') {
        a.removeLast();
        operation = a.join();
      }

      math();
    }

    emit(RefreshTasksUIState());
  }

  void back() {
    while (secondNumberCount >= 0) {
      if (secondNumberCount == 0) {
        secondNumber == null;
        break;
      }
      backOne();
      secondNumberCount--;
    }
    while (firstNumberCount >= 0) {
      if (firstNumberCount == 0) {
        firstNumber == null;
        break;
      }
      backOne();
      firstNumberCount--;
    }
  }

  void backOne() {
    var a = operation.split("");
    if (operationEnum == OperationEnum.nul && secondNumber == null) {
      firstNumber = firstNumber! - int.parse(a.last);
      firstNumber = firstNumber! / 10;
    } else if (operationEnum != OperationEnum.nul &&
        secondNumber != null &&
        secondNumber == 0 &&
        firstNumber != null) {
      secondNumber = secondNumber! - int.parse(a.last);
      secondNumber = secondNumber! / 10;
    } else if (secondNumber == 0) {}
    math();
    a.removeLast();
    operation = a.join();
    emit(RefreshTasksUIState());
  }

  String resultSize() {
    var a = result.toString();
    var b = a.split('');

    if (result > 100000000) {
      var b = result.toString().split("");
      return result.toString().replaceRange(1, null, 'e${b.length - 3}');
    } else if (result % 1 == 0 - 0.0001) {
      var s = result.toString().split("");

      return result
          .toString()
          .replaceAll('0', '1')
          .replaceRange(1, null, 'e-${s.length - 2}');
    } else if (b.length >= 11) {
      return b.getRange(0, 11).join();
    }

    return result.toString();
  }

  void mathInOperation(String value) {
    var m = operation.split("");
    if (operation.length > 1 &&
        m.last != "*" &&
        m.last != "+" &&
        m.last != "-" &&
        m.last != "/" &&
        m.last != "%") {
      operation += value;
    } else if (m.last == "*" ||
        m.last == "+" ||
        m.last == "-" ||
        m.last == "/" ||
        m.last == "%") {
      m.removeLast();
      m.add(value);
      operation = m.join();
    }
    emit(RefreshTasksUIState());
  }

  void addZero() {
    operation += "0";
    emit(RefreshTasksUIState());
  }

  void addPoint() {
    var a = operation.split('');
    if (a.last != '.') {
      operation += ".";
    }
    emit(RefreshTasksUIState());
  }

  Future<void> saveData() async {
    emit(RefreshTasksUIState());
  }

  void getData() {
    emit(RefreshTasksUIState());
  }
}
