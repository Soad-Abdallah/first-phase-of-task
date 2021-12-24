// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/modules/counter/cubit/cubit.dart';
import 'package:fristapp/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  int counter=1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener:(BuildContext context, CounterStates state){
          if(state is CounterMinusState)
          {
            print('minus state ${state.counter}');
          }

          if(state is CounterPlusState)
          {
            print('plus state ${state.counter}');
          }
        },
        builder: (BuildContext context, CounterStates state){
          return Scaffold(
          appBar: AppBar(
            title: 
            Text(
              'Counter',
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                TextButton(
                  onPressed: ()
                  {
                    CounterCubit.get(context).minus();
                  }, 
                  child: Text(
                    'MINUS'
                  ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w800,
          
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){
                     CounterCubit.get(context).plus();
                  }, 
                  child: Text(
                    'PLUS'
                  ),
                  ),
                
              ],
            ),
          ),
        );
        },

        
      ),
    );
  }
}

