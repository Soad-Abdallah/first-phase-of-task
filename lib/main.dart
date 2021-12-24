// ignor_for_file: prefer_const_construction
// ignore_for_file: use_key_in_widget_constructors, unused_import


//import 'dart:html';

//import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/final_task_app/cubit/cubit.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/cubit.dart';
import 'package:fristapp/layout/shop_app_layout/shop_app_layout.dart';
import 'package:fristapp/layout/social_app/cubit/cubit.dart';
import 'package:fristapp/layout/social_app/social_layout.dart';
import 'package:fristapp/layout/task_app/cubit/cubit.dart';
import 'package:fristapp/layout/task_app/task_layoyt.dart';
import 'package:fristapp/model/task_app/Task_user_model.dart';
import 'package:fristapp/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:fristapp/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:fristapp/modules/social_app/social_login/social_login_screen.dart';
import 'package:fristapp/modules/task_app/task_logout/task_logout_screen.dart';
import 'package:fristapp/shared/component/constants.dart';
import 'package:fristapp/shared/cubit/cubit.dart';
import 'package:fristapp/shared/cubit/states.dart';
import 'package:fristapp/shared/network/local/cache_helper.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';
import 'package:fristapp/shared/styles/bloc_observer.dart';
import 'package:fristapp/shared/styles/themes.dart';
import 'package:sqflite/sqflite.dart';
import 'layout/final_task_app/task_layoyt.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/basics/login/login_screen.dart';
import 'modules/counter/Counter_screen.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

void main()async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  Widget widget;
  //bool OnBoarding =  await CachHelper.getData(key : 'onBoarding');
  //token =  await CachHelper.getData(key : 'token');
  uId = await CachHelper.getData(key : 'uId');
  // if(OnBoarding == true)
  // {
  //   if(token != null) widget = ShopAppLayout();
  //   else widget = ShopLoginScreen();
  // }else widget = OnBoardingScreen();

  if(uId != null)
  {
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }
  //Database ref =
  //await FirebaseDatabase.instance.ref("user").child("ffffffffffffffff").set({
  // String? key = FirebaseDatabase.instance.ref("user").push().key;
  // print(key);
  // await FirebaseDatabase.instance.ref("user").child(key.toString()).set({  
  //   'id':12,
  //   'name': 'soad',
  // }).then((value){

  //   //print(FirebaseDatabase.instance.ref("user").push().key);
  // });
  // UsersModel model ;
  // await FirebaseDatabase.instance.ref("users/${'123322222'}").once().then((value){
  //   model =UsersModel.fromSnapshot(value.snapshot);
  //   print('ddddddddddddddddddddddd');
  //   print(model.age);
  // }).catchError((onError){
  //   //print('ddddddddddddddddddddddd');
  //   print(onError.toString());
  // });

  // TaskCubit.get(context).AddUser(
  //   name: "soad",
  //   age: "16",
  //   bio: "ffdfdfd",
  //   birthDay: "9/21/1998",
  //   );
  

// Print the data of the snapshot
//print(event.snapshot.value); 
  //print( FirebaseDatabase.instance.ref("users/123").key);
  //print( FirebaseDatabase.instance.ref("users/123").parent!.key);

  Stream<DatabaseEvent> data = FirebaseDatabase.instance.ref("Users").onChildAdded;
  Stream<DatabaseEvent> data2 = FirebaseDatabase.instance.ref("Users").onValue;
  

  print(data2.toList().then((value){
    print(value);
  }));

//   FirebaseFirestore.instance.collection("cities").add({
//     "name": "Tokyo",
//     "country": "Japan"
// })
// .then((docRef) {
//   print("ffffffffffffffffffffffff");
//     print(docRef.id);
// }).catchError((error) {
//     print(error);
// });

  runApp(MyApp(statrWidget: widget));
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  late final Widget statrWidget;
  MyApp({
    required this.statrWidget,
  });
  
  @override
  Widget build(BuildContext context)
   {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit(),),
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness(),),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCatecoriesData(),),
        BlocProvider(create: (context) => SocialCubit()..getUserData()),
        //BlocProvider(create: (context) => TaskCubit(),),
        BlocProvider(create: (context) => FinalTaskCubit()..getAllUsers()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
          theme: lightTheme,
          darkTheme:darkTheme,
          themeMode: AppCubit().get(context).IsDark ? ThemeMode.dark :ThemeMode.light,
          debugShowCheckedModeBanner:false,
          home: FinalTaskLayout(),
        );
        } ,
        ),
    );   
  }
}


