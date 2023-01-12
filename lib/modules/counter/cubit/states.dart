import 'package:bmi/modules/counter/cubit/cubit.dart';
import 'package:bloc/bloc.dart';

abstract class CounterStates {}
class CounterInitialState extends CounterStates {}
class CounterMinusState extends CounterStates {
  final int counter;

  CounterMinusState(this.counter);
}
class CounterPlusState extends CounterStates {
   final int counter;

  CounterPlusState(this.counter);

}






