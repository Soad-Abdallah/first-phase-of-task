import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/final_task_app/cubit/states.dart';
import 'package:fristapp/model/final_task/Task_user_model.dart';
import 'package:fristapp/modules/final_task_app/task_add_user/task_add_user_screen.dart';
import 'package:fristapp/modules/final_task_app/task_home/task_home_screen.dart';
import 'package:fristapp/modules/final_task_app/task_setting/task_setting_screen.dart';
import 'package:fristapp/shared/component/constants.dart';

class FinalTaskCubit extends Cubit<TaskStates> {
  FinalTaskCubit() : super(TaskInitialState());

  static FinalTaskCubit get(context) => BlocProvider.of(context);

  void userAdd ({
    required String name,
    required String phone,
    required String birthDay,
    required String age,
    required String bio
  }){
    UsersModel model = UsersModel(
      name: name,
      phone: phone,
      bio: bio,
      birthDay : birthDay,
      age : age, 
      id: '',
    );
    FirebaseFirestore.instance.collection(Users)
    .add(model.toMap()
    ).then((value){
      model.id = value.id.toString();
      print(model.id);
      print(model.bio);
      FirebaseFirestore.instance.collection(Users).doc("${model.id}").update({
        'id': model.id,
      });
      UsersList.add(model.toMap());
      emit(TaskAddUserSuccessState());
    }).catchError((Error){
      emit(TaskAddUserErrorsState(Error.toString()));
    });

  }


  late List<Map> UsersList =[];
  void getAllUsers() {
    //UsersList =[];
    emit(TaskGetUserLoadingState());
    FirebaseFirestore.instance
    .collection(Users)
    .get()
    .then((value){
      value.docs.forEach((element) {
        UsersList.add(element.data());
      });
      emit(TaskGetAllUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(TaskGetAllUserErrorState(error));
    });
  }
  
  void UpdateUser(UsersModel model , String id)
  {  
    emit(TaskEditeUserLoadingState());
    print(id);
    print(model.toMap());
    FirebaseFirestore.instance.collection(Users)
    .doc(id)
    .update(model.toMap()).then((value){
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      //getAllUsers();
      emit(TaskEditeUserSuccessState());
    }).catchError((onError){
      emit(TaskEditeUserErrorState(onError));
    });


  }
  // late UsersModel model;
  // Future<void> AddUser(
  //   {
  //     required String name,
  //     required String birthDay,
  //     required String age,
  //     required String bio,
  //     required String phone,
  //   })async {
  //     emit(TaskAddUserLoadingState());
  //     String? key = FirebaseDatabase.instance.ref(User).push().key.toString();
  //     model = UsersModel(
  //       key: key,
  //       name: name,
  //       age: age,
  //       birthDay: birthDay,
  //       bio: bio,
  //       phone: phone,
  //       );
  //     await FirebaseDatabase.instance.ref(User).child("${model.key}").set(model.toMap()
  //     ).then((value){
  //       emit(TaskAddUserSuccessState());
  //     }).catchError((onError){
  //       emit(TaskAddUserErrorsState(onError));
  //     });
  // }
  // List<Map<String,dynamic>> UsersList = [];
  // Future<void> getTaskUser() async {
  //   await FirebaseDatabase.instance.ref(User).once().then((value){
      
  //   });
  // }

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