// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fristapp/model/user/user_model.dart';

class  UsersScreen extends StatelessWidget {
  List <UsersModel> Users =[
    UsersModel(
      id: 1,
      name: 'soad abdallah kamal',
      phone: '+02456634485',
    ),
    UsersModel(
      id: 2,
      name: 'mohsen abdallah kamal',
      phone: '+02456634222',
    ),
    UsersModel(
      id: 3,
      name: 'maisa abdallah kamal',
      phone: '+02456634485',
    ),
    UsersModel(
      id: 1,
      name: 'soad abdallah kamal',
      phone: '+02456634485',
    ),
    UsersModel(
      id: 2,
      name: 'mohsen abdallah kamal',
      phone: '+02456634222',
    ),
    UsersModel( 
      id: 3,
      name: 'maisa abdallah kamal',
      phone: '+02456634485',
    ),
    UsersModel(
      id: 1,
      name: 'soad abdallah kamal',
      phone: '+02456634485',
    ),
    UsersModel(
      id: 2,
      name: 'mohsen abdallah kamal',
      phone: '+02456634222',
    ),
    UsersModel(
      id: 3,
      name: 'maisa abdallah kamal',
      phone: '+02456634485',
    ),
    UsersModel(
      id: 1,
      name: 'soad abdallah kamal',
      phone: '+02456634485',
    ),
    UsersModel(
      id: 2,
      name: 'mohsen abdallah kamal',
      phone: '+02456634222',
    ),
    UsersModel( 
      id: 3,
      name: 'maisa abdallah kamal',
      phone: '+02456634485',
    ),
  
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users'),
      ),
      body: ListView.separated(
        itemBuilder: (context , index) => buildUsersItem(Users[index]), 
        separatorBuilder: (context , index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ), 
        itemCount: Users.length,
        ),
    );
  }
   Widget buildUsersItem(UsersModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                '${user.id}'
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                  ),
              ],
            ),
          ],
        ),
      );
}