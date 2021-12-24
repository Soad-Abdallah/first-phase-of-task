import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/cubit.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/states.dart';
import 'package:fristapp/modules/basics/login/login_screen.dart';
import 'package:fristapp/modules/shop_app/search/search_screen.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/network/local/cache_helper.dart';

class ShopAppLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state) 
      {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'salla',
              ),
            actions: [
              IconButton(
                onPressed: (){
                  NavigetTo(context, searchScreen());
                }, 
                icon: Icon(
                  Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home),
                  label : 'HOME',
                  ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                  ),
                  label : 'CATEOGRIES',
                  ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  ),
                  label : 'FAVORITES',
                  ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  ),
                  label : 'SETTINGS',
                  ),
            ],
            ),
        );
      }, 
    );
  }
}