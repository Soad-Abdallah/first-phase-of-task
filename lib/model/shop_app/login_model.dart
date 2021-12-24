// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';

class ShopLoginModel{
  late bool status;
  late String message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String,dynamic> Json)
  {
    status = Json ['status'];
    message = Json['message'];
    data = UserData.fromJson(Json['data']);
  }

}

class UserData{
  int? id ;
  String? name ;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson(Map<String,dynamic> Json){
  
  if(Json==null)
  {
    id = null;
    name = null;
    email =null;
    phone =null;
    image =null;
    points=null;
    credit=null;
    token =null;
 }else{
    id = Json['id'] ;
    name = Json['name'];
    email = Json['email'];
    phone = Json['phone'];
    image = Json['image'];
    points = Json['points'];
    credit = Json['credit'];
    token = Json['token'];
 }
}

}