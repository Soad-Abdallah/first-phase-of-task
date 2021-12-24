//import 'dart:html';

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'heloookkkkko',
        ),
        actions:
         [
          IconButton(
            icon: Icon(Icons.notification_add
            ),
            onPressed: ()
            {
              print('notifactionpresedhhhhhhhhhhh');
            },
          ),
          Icon(
            Icons.outgoing_mail),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: 
        [  
          Text(
            'log in',
          ),
          TextFormField(
            initialValue: 'Email',
          ),
          TextFormField(
            initialValue: 'password',
          ),
        ],
      ),
    );

  }
}