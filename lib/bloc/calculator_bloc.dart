import 'package:calculator_app_new/bloc/calculator_events.dart';
import 'package:calculator_app_new/bloc/calculator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorBloc extends Bloc<CalculatorEvents, CalculatorState> {
  final int maxInputLength = 32;

  CalculatorBloc() : super(CalculatorInitialBlocState(input: '', output: '0')) {
    on<CalculatorEvents>(handleCalculatorEvent);
  }

  void handleCalculatorEvent(
      CalculatorEvents event, Emitter<CalculatorState> emit) {
    if (event is CalculatorButtonsEvent) {
      // Emitter take state and send to ui
      mapButtonPressedToState(event, emit);
    }
  }

  void mapButtonPressedToState(
      CalculatorButtonsEvent event, Emitter<CalculatorState> emit) {
    CalculatorState currentState = state; // bloc send state to ui

    try {
      if (event.ButtonText == 'C') {
        emit(CalculatorInitialBlocState(input: '', output: '0'));
      } else if (event.ButtonText == '=') {
        if (currentState.input.length < maxInputLength) {
          String input = currentState.input.replaceAll('×', '*');
          input = input.replaceAll('÷', '/');
          String output = _getResult(input);
          emit(CalculatorInitialBlocState(
              input: currentState.input, output: output));
        }
      } else if (event.ButtonText == '⌫') {
        String input =
            currentState.input.substring(0, currentState.input.length - 1);
        emit(CalculatorInitialBlocState(
            input: input, output: currentState.output));
      } else {
        if (currentState.input.length < maxInputLength) {
          String input = currentState.input + event.ButtonText;
          emit(CalculatorInitialBlocState(
              input: input, output: currentState.output));
        }
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  String _getResult(String input) {
    Parser p = Parser();
    Expression exp = p.parse(input);
    ContextModel contextModel = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, contextModel);
    return eval.toString();
  }
}
