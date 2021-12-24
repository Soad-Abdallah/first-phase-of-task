import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/news_app/cubit/cubit.dart';
import 'package:fristapp/layout/news_app/cubit/states.dart';
import 'package:fristapp/shared/component/component.dart';

class  scienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state) {
        var list = NewsCubit.get(context).Science;
        return articleBuilder(list);
      },
    
    );
  }
}