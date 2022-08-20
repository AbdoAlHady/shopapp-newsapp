abstract class counterStates {}

class CounterInitialState extends counterStates {}

class CounterPlusState extends counterStates {
  final int counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends counterStates {
  final int counter;

  CounterMinusState(this.counter);
}
