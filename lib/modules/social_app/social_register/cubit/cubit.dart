import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/model/social_app/social_user_model.dart';
import 'package:fristapp/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
   required String name,
   required String email,
   required String password,
   required String phone,
  }){
  emit(SocialRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email, 
    password: password,
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      userCreat(
        name: name, 
        email: email, 
        phone: phone, 
        UId:value.user!.uid
        );
      //emit(SocialRegisterSuccessState());
    }).catchError((Error){
      print(Error.toString());
      emit(SocialRegisterErrorState(Error.toString()));
    });
}

  void userCreat ({
    required String name,
    required String email,
    required String phone,
    required String UId,
  }){
    SocialUserModel model = SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: UId,
      bio: 'write you bio ...',
      cover: 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
      image: 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
      isEmailVerfied: false,
    );
    FirebaseFirestore.instance.collection('Users')
    .doc(UId)
    .set(model.toMap()).then((value){
      emit(SocialCraetUserSuccessState());
    }).catchError((Error){
      emit(SocialCraetUserErrorState(Error.toString()));
    });

  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}