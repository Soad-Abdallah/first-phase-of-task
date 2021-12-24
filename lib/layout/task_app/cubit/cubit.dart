import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/task_app/cubit/states.dart';
import 'package:fristapp/model/task_app/Task_user_model.dart';
import 'package:fristapp/modules/task_app/task_add_user/task_add_user_screen.dart';
import 'package:fristapp/modules/task_app/task_home/task_home_screen.dart';
import 'package:fristapp/modules/task_app/task_setting/task_setting_screen.dart';
import 'package:fristapp/shared/component/constants.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitialState());

  static TaskCubit get(context) => BlocProvider.of(context);

  late UsersModel model;
  Future<void> AddUser(
    {
      required String name,
      required String birthDay,
      required String age,
      required String bio,
      required String phone,
    })async {
      emit(TaskAddUserLoadingState());
      String? key = FirebaseDatabase.instance.ref(Users).push().key.toString();
      model = UsersModel(
        key: key,
        name: name,
        age: age,
        birthDay: birthDay,
        bio: bio,
        phone: phone,
        );
      await FirebaseDatabase.instance.ref(Users).child("${model.key}").set(model.toMap()
      ).then((value){
        emit(TaskAddUserSuccessState());
      }).catchError((onError){
        emit(TaskAddUserErrorsState(onError));
      });
  }
  List<Map<String,dynamic>> UsersList = [];
  Future<void> getTaskUser() async {
    await FirebaseDatabase.instance.ref(Users).once().then((value){
      
    });
  }

 /* TaskUserModel? Usermodel;

  void getUserData(){
    emit(TaskGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .get()
        .then((value)
    {
          print(value.data());
          Usermodel = TaskUserModel.fromJson(value.data());
          emit(TaskGetUserSuccessState());
    })
        .catchError((error) {
          print(error.toString());
      emit(TaskGetUserErrorState(error.toString()));

    });
  }*/

  int currentIndex = 0;
  List<Widget> screens =[
    TaskHomeScreen(),
    TaskAddUserScraan(),
    TaskSettingScreen(),
  ];
  List<String> titles =[
    'Home',
    'Add User',
    'Settings',
  ];
  void changeBottomNav(int index){
        currentIndex = index;
        emit(TaskChangeBottomNavState());
  }
}