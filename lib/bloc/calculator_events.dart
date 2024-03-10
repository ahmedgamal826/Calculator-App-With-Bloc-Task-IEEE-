abstract class CalculatorEvents {}

class CalculatorButtonsEvent extends CalculatorEvents {
  final String ButtonText;

  CalculatorButtonsEvent({required this.ButtonText});
}
