import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fristapp/layout/social_app/social_layout.dart';


import 'package:fristapp/modules/social_app/social_login/cubit/cubit.dart';
import 'package:fristapp/modules/social_app/social_login/cubit/states.dart';
import 'package:fristapp/modules/social_app/social_register/social_register_screen.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/network/local/cache_helper.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener:(context,State){
          if(State is SocialLoginErrorState)
          {
            showToast(msg: State.Error, 
            state: toastStates.ERROR,
            );
          }
          if(State is SocialLoginSuccessState){
            CachHelper.saveData(key:'uId', 
            value: State.uId,
            ).then((value){
              NavidetAndFinish(context, SocialLayout());
            });
          }
          },
        builder:(context,State){
          return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style:Theme.of(context).textTheme.headline3!.copyWith(
                        color:Colors.black,
                        fontWeight: FontWeight.w900, ),
                      ),
                    Text(
                      'login now to communicat with your friends',
                      style:Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defultFormField(
                      controller: emailController, 
                      type: TextInputType.emailAddress, 
                      validate: (Value){
                        if(Value!.isEmpty)
                        {
                          return 'please enter your email address';
    
                        }return null;
                      }, 
                      lable: 'Email Adress', 
                      prefix: Icons.email_outlined,
                      ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defultFormField(
                      controller: passwordController, 
                      type: TextInputType.visiblePassword, 
                      validate: (value){
                        if(value!.isEmpty)
                        {
                          return 'password is too short';
                        }return null;
                      }, 
                      lable: 'Password', 
                      suffix: SocialLoginCubit.get(context).suffix,
                      onPressed: (){
                        SocialLoginCubit.get(context).changePasswordVisibility();
                      },
                      prefix: Icons.lock_outline_rounded,
                      obsCuretext: SocialLoginCubit.get(context).IsPassward,
                      onSubmit: (value){
                        if(formKey.currentState!.validate()){
                              SocialLoginCubit.get(context).UserLogin(
                              email: emailController.text, 
                              passWord: passwordController.text);
                            }
                      },
                      ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ConditionalBuilder(
                      condition: State is! SocialLoginLoadingState, 
                      builder: (context)=> defulteButton(
                          function: (){
                            if(formKey.currentState!.validate()){
                              SocialLoginCubit.get(context).UserLogin(
                              email: emailController.text, 
                              passWord: passwordController.text);
                            }
                            }, 
                          text: 'LOGIN',
                           ),
                      fallback: (context)=> Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          ),
                       defultTextButton(
                         onPressed: (){
                           NavigetTo(context, SocialRegisterScreen());
                         }, 
                         text: 'register'
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      );
        }
      ),
    );
  }
}