import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/model/shop_app/home_model.dart';
import 'package:fristapp/model/shop_app/login_model.dart';
import 'package:fristapp/modules/shop_app/shop_login/cubit/states.dart';
import 'package:fristapp/shared/network/end_points.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  
  late ShopLoginModel loginModel;
  void UserLogin({
  required String email,
  required String passWord
})
{
  emit(ShopLoginLoadingState());
  DioHelper.postData(
    url: LOGIN, 
    data: 
    {
      'email':email,
      'password':passWord,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      print(loginModel.message);
      print(loginModel.status);
      print(loginModel.data!.email);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
}

  bool IsPassward = true;
  IconData suffix = Icons.remove_red_eye_outlined;
  void changePasswordVisibility(){
      IsPassward = !IsPassward;
      suffix = IsPassward? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
      emit(ShopChangePasswordVisibilityState());
  }

}