import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/enums.dart';
import 'cubit/calculator_cubit.dart';
import 'homepage.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<CalculatorCubit>(
          create: (context) => CalculatorCubit(sharedPreferences)),
    ], child: const Calculator()),
  );
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
      listener: (context, state) {},
      builder: (context, state) {
        CalculatorCubit calculatorCubit = CalculatorCubit.get(context);
        return MaterialApp(
          darkTheme: calculatorCubit.themeEnum == ThemeEnum.light
              ? ThemeData.light()
              : ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          title: 'calculator',
          home: const HomePage(),
        );
      },
    );
  }
}
