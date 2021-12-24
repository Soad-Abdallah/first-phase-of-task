import 'package:flutter/material.dart';

class MBIResulteScreen extends StatelessWidget {
  final double Resulte;
  final bool ismale;
  final int age;
  MBIResulteScreen({
    required this.Resulte,
    required this.ismale,
    required this.age,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'BMI Resulte'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${ismale ? 'Male' : 'Female'}',
               style: TextStyle(
                 fontSize: 25.0,
                 fontWeight: FontWeight.bold,
               ) ,
            ),
            Text(
              'Result : ${Resulte.round()}',
               style: TextStyle(
                 fontSize: 25.0,
                 fontWeight: FontWeight.bold,
               ) ,
            ),
            Text(
              'Age : $age',
               style: TextStyle(
                 fontSize: 25.0,
                 fontWeight: FontWeight.bold,
               ) ,
            ),
          ],
          ),
      ),
    );
  }
}