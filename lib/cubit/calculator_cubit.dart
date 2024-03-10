import 'package:calculator_app_new/cubit/calculator_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CalaculatorCubit extends Cubit<CalculatorCubitState> {
  CalaculatorCubit() : super(CalculatorInitialState());

  final int maxInputLength = 32;

  void onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      state.input = '';
      state.output = '0';
    } else if (buttonText == '=') {
      if (state.input.length < maxInputLength) {
        state.input = state.input.replaceAll('×', '*');
        state.input = state.input.replaceAll('÷', '/');
        state.output = getResult();
      }
    } else if (buttonText == '⌫') {
      state.input =
          state.input.substring(0, state.input.length - 1); // delete number
    } else {
      if (state.input.length < maxInputLength) {
        state.input += buttonText;
      }
    }

    emit(CalculatorCubitState(input: state.input, output: state.output));
  }

  // to make the mathmatical expression and get the result
  String getResult() {
    try {
      Parser p = Parser(); // create a mathmatical expression from input string
      Expression exp =
          p.parse(state.input); // convert text into mathmatical expression
      ContextModel contextModel =
          ContextModel(); // keeps track of all known variables and functions
      double eval = exp.evaluate(
          EvaluationType.REAL, contextModel); // evaluate the expression
      return eval.toString();
    } catch (e) {
      return 'Error'; // to show error
    }
  }
}
