import 'dart:math';

import 'package:flutter/material.dart';

import '../bmi_result/bmi_resulte_screen.dart';

class  BMIScreen extends StatefulWidget {

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  bool ISMALE = true;
  double SliderValue = 120;
  int Weight = 40;
  int Age =20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
        ) ,
        ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          ISMALE =true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: ISMALE ? Colors.blue : Colors.grey[400],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/male1.png'),
                              width: 90,
                              height: 90,
                              ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MALE',
                              style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 25.0,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          ISMALE = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: !ISMALE ? Colors.blue : Colors.grey[400],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/female1.png'),
                              width: 90,
                              height: 90,
                              ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'FEMALE',
                              style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 25.0,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[400],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     'HIGHT',
                     style: TextStyle(
                       fontWeight:FontWeight.bold,
                       fontSize: 25.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                     '${SliderValue.round()}',
                     style: TextStyle(
                       fontWeight:FontWeight.w800,
                       fontSize: 40.0,
                      ),
                    ),
                      Text(
                     'CM',
                     style: TextStyle(
                       fontWeight:FontWeight.bold,
                       fontSize: 20.0,
                      ),
                    ),
                      ],
                    ),
                    Slider(
                      value: SliderValue,
                      max: 220,
                      min: 80,
                      onChanged: (value)
                      {
                        setState(() {
                          SliderValue = value;
                        });
                        print(value.round());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[400],
                    ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           'WEIGHT',
                           style: TextStyle(
                             fontWeight:FontWeight.bold,
                             fontSize: 25.0,
                            ),
                          ),
                          Text(
                           '${Weight}',
                           style: TextStyle(
                             fontWeight:FontWeight.w800,
                             fontSize: 40.0,
                           ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    Weight--;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_rounded,
                                ),
                                mini: true,
                                heroTag: 'Weight-',
                                ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    Weight++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                ),
                                mini: true,
                                heroTag: 'Weight+',
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           'AGE',
                           style: TextStyle(
                             fontWeight:FontWeight.bold,
                             fontSize: 25.0,
                            ),
                          ),
                          Text(
                           '${Age}',
                           style: TextStyle(
                             fontWeight:FontWeight.w800,
                             fontSize: 40.0,
                           ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    Age--;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_rounded,
                                ),
                                mini: true,
                                heroTag: 'Age-',
                                ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    Age++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                ),
                                mini: true,
                                heroTag: 'Age+',
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              onPressed: () { 
                double resulte = Weight/pow(SliderValue/100, 2);
                print(resulte.round());
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => MBIResulteScreen(
                      age: Age,
                      Resulte: resulte, 
                      ismale: ISMALE,
                      ),
                  ),
                  );
               },
              child: Text(
                'CALCULATE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize:20.0,
                  ),
              ) ,
              ),
          )
        ],
      ),
    );
  }
}