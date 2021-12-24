import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/modules/social_app/social_login/cubit/states.dart';

import 'package:fristapp/shared/network/end_points.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  
  void UserLogin({
  required String email,
  required String passWord
})
{
  emit(SocialLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email, 
    password: passWord,
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((Error){
      emit(SocialLoginErrorState(Error.toString()));
    });
}

  bool IsPassward = true;
  IconData suffix = Icons.remove_red_eye_outlined;
  void changePasswordVisibility(){
      IsPassward = !IsPassward;
      suffix = IsPassward? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
      emit(SocialChangePasswordVisibilityState());
  }

}