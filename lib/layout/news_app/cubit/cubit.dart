import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/news_app/cubit/states.dart';
import 'package:fristapp/modules/news_app/business/business_screen.dart';
import 'package:fristapp/modules/news_app/science/science_screen.dart';
import 'package:fristapp/modules/news_app/sports/sports_screen.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsIntialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
        ),
      label: 'Business',
      ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
        ),
      label: 'Sports',
      ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
        ),
      label: 'science',
      ),
  ];
  
  List<Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    scienceScreen(),
  ];
 
  void ChangeBottomNavBarr(int index) {
    currentIndex = index;
    if(index == 1)
    getSports();
    if(index==2)
    getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> Business=[];
  
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getdata(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      }
      ).then((value){
        Business=value.data['articles'];
        print(Business[0]['title']);
        emit(NewsGetBusinessSuccessStete());
      }).catchError((Error){
        print(Error.toString());
        emit(NewsGetBusinessErrorStete(Error.toString()));
      });
       
  }
  
  List<dynamic> Sports=[];
  
  void getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getdata(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      }
      ).then((value){
        Sports=value.data['articles'];
        print(Business[0]['title']);
        emit(NewsGetSportsSuccessStete());
      }).catchError((Error){
        print(Error.toString());
        emit(NewsGetSportsErrorStete(Error.toString()));
      });
       
  }

List<dynamic> Science=[];
  
  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getdata(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      }
      ).then((value){
        Science=value.data['articles'];
        print(Business[0]['title']);
        emit(NewsGetScienceSuccessStete());
      }).catchError((Error){
        print(Error.toString());
        emit(NewsGetScienceErrorStete(Error.toString()));
      });
       
  }


List<dynamic> Search=[];
  
  void getSearch(String value){
    
    emit(NewsGetSearchLoadingState());
    Search=[];
    DioHelper.getdata(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      }
      ).then((value){
        Search=value.data['articles'];
        emit(NewsGetSearchSuccessStete());
      }).catchError((Error){
        print(Error.toString());
        emit(NewsGetSearchErrorStete(Error.toString()));
      });
       
  }

}