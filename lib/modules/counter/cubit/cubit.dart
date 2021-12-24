import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterIntialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;
  void minus(){
    counter --;
    emit(CounterMinusState(counter));
  }

  void plus(){
    counter ++;
    emit(CounterPlusState(counter));
  } 
}