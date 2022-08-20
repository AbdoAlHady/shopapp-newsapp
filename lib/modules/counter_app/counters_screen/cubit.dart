import 'package:bmicalc/modules/counter_app/counters_screen/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class counterCubit extends Cubit<counterStates> {
  counterCubit() : super(CounterInitialState());

  static counterCubit get(context) => BlocProvider.of(context);
  int counter = 1;
  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
