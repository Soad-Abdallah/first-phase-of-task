// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, camel_case_types, must_be_immutable, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:fristapp/modules/shop_app/shop_register/shop_register_screen.dart';
import 'package:fristapp/shared/component/component.dart';


class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var EmailAdressController = TextEditingController();
  var PasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordNotShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  Text(
                    'login',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height : 20.0),
                  defultFormField(
                    controller:EmailAdressController, 
                    type: TextInputType.emailAddress, 
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'email  must not be empity ';
                      }
                      return null;
                    },
                    lable: 'Email Adress', 
                    prefix: Icons.email,
                    ),
                  SizedBox(height : 20.0),
                  defultFormField(
                    controller: PasswordController, 
                    type: TextInputType.visiblePassword, 
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'password must not be empity';
                      }
                      return null ;
                    }, 
                    lable: 'PassWord', 
                    prefix: Icons.lock_outline_rounded, 
                    suffix: isPasswordNotShow? Icons.visibility :Icons.visibility_off,
                    obsCuretext: isPasswordNotShow,
                    onPressed: ()
                    {
                      setState(() {
                        isPasswordNotShow = !isPasswordNotShow;
                        
                      });
                    }
                    ),
                  SizedBox(height : 20.0),
                  defulteButton(
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                      }
                    }, 
                    text: 'login', 
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                     [
                       Text(
                         'Don\'t have an acount?'
                       ),
                      defultTextButton(
                        onPressed: ()
                        {
                            print('ddddddddddddddddddd');
                            NavigetTo(context,ShopRegisterScreen());          
                        },
                        text: 'register',
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}