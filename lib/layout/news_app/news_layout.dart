import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/news_app/cubit/cubit.dart';
import 'package:fristapp/layout/news_app/cubit/states.dart';
import 'package:fristapp/modules/news_app/search/search_screen.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/cubit/cubit.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder: (context, state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
      appBar: AppBar(
        title: Text(
          'News App'
        ),
        actions: [
          IconButton(
            onPressed: (){
              NavigetTo(context,SearchScreen());
            }, 
            icon: Icon(
              Icons.search,
              ), 
            ),
          IconButton(
            onPressed: (){
              AppCubit().get(context).ChangeAppMode();
            }, 
            icon: Icon(
              Icons.brightness_4_rounded,
              ), 
            ),
        ],
      ),
      body: cubit.screens[cubit.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          cubit.ChangeBottomNavBarr(index);
        },
        currentIndex: cubit.currentIndex,
        items: cubit.bottomItems,
        ),
    );
      }, 
      );
  }
}