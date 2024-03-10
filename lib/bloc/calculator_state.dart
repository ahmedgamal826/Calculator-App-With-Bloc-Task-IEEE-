abstract class CalculatorState {
  get input => null;

  get output => null;
}

class CalculatorInitialBlocState extends CalculatorState {
  final String input;
  final String output;

  CalculatorInitialBlocState({required this.input, required this.output});
}
