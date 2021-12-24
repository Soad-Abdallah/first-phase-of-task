import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/modules/task_app/task_login/cubit/states.dart';

class TaskLoginCubit extends Cubit<TaskLoginStates>
{
  TaskLoginCubit() : super(TaskLoginInitialState());
  static TaskLoginCubit get(context) => BlocProvider.of(context);
  
  void UserLogin({
  required String email,
  required String passWord
})
{
  emit(TaskLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email, 
    password: passWord,
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      emit(TaskLoginSuccessState(value.user!.uid));
    }).catchError((Error){
      emit(TaskLoginErrorState(Error.toString()));
    });
}

  bool IsPassward = true;
  IconData suffix = Icons.remove_red_eye_outlined;
  void changePasswordVisibility(){
      IsPassward = !IsPassward;
      suffix = IsPassward? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
      emit(TaskChangePasswordVisibilityState());
  }

}