import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fristapp/layout/shop_app_layout/shop_app_layout.dart';
import 'package:fristapp/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:fristapp/modules/shop_app/shop_login/cubit/states.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/network/local/cache_helper.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,State){
          if(State is ShopLoginSuccessState)
          {
            if(State.loginModel.status == true)
            {
              print(State.loginModel.message);
              print(State.loginModel.data!.token);
              CachHelper.saveData(
                key: 'token', 
                value: State.loginModel.data!.token).then((value){
                   NavidetAndFinish(context, ShopAppLayout());
                });
            }else{
              print(State.loginModel.message);
              showToast(msg:State.loginModel.message,
              state: toastStates.ERROR);
            }
            
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
                      'login now to browse our hot offers',
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
                      suffix: ShopLoginCubit.get(context).suffix,
                      onPressed: (){
                        ShopLoginCubit.get(context).changePasswordVisibility();
                      },
                      prefix: Icons.lock_outline_rounded,
                      obsCuretext: ShopLoginCubit.get(context).IsPassward,
                      onSubmit: (value){
                        if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).UserLogin(
                              email: emailController.text, 
                              passWord: passwordController.text);
                            }
                      },
                      ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ConditionalBuilder(
                      condition: State is! ShopLoginLoadingState, 
                      builder: (context)=> defulteButton(
                          function: (){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).UserLogin(
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
                         onPressed: (){}, 
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