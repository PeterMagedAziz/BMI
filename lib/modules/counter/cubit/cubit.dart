import 'package:bmi/modules/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;
  void Minus (){
    counter--;
    emit(CounterMinusState(counter));
  }
  void Plus (){
    counter++;
    emit(CounterPlusState(counter));
  }
}
