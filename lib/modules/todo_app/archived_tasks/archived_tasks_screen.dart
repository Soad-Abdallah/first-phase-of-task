import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/cubit/cubit.dart';
import 'package:fristapp/shared/cubit/states.dart';

class ArchivedTaskScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){} ,
      builder:(context,state){
        var tasks =AppCubit().get(context).Archivedtasks;
        return tasksBiulder(
          tasks: tasks);
      },
    );
  }
  
}
