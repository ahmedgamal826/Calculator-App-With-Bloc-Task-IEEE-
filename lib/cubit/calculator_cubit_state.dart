class CalculatorCubitState {
  String input; // state 1
  String output; // state 2

  CalculatorCubitState({required this.input, required this.output});
}

class CalculatorInitialState extends CalculatorCubitState {
  CalculatorInitialState() : super(input: '', output: '0');
}
