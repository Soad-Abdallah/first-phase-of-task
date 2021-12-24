import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/component/constants.dart';
import 'package:fristapp/shared/cubit/cubit.dart';
import 'package:fristapp/shared/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayoutScreen extends StatelessWidget  {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState> ();
  var formKey = GlobalKey<FormState> ();

  
  //@override
  // void initState() {
  //   super.initState();
  //   creatDataBase();
  //}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext,)=> AppCubit()..creatDataBase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context, state){
          if (state is AppInsertDataBaseState)
          {
            Navigator.pop(context);
          }
        },
        builder:(context, state){
          AppCubit cubit = AppCubit().get(context);
          return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            cubit.titels[cubit.currentIndex],
          ),
        ),
        body: ConditionalBuilder(
          condition: state is ! AppGetDatabaseLoadingState ,
          builder: (context) => cubit.Screens[cubit.currentIndex],
          fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            {// try
            // {
            //   var name = await getName();
            //   print(name);
            //   throw('انا عملت ايرورر');
            // }
            // catch(error)
            // {
            //   print('error is ${error.toString()}');
            // }
            // getName().then((value)
            // {
            //   print(value);
            //   throw('انا عملت ايرورر');
            // }).catchError((error)
            // {
            //   print('error is ${error.toString()}');
            // });
            }
            if(cubit.isBottomSheetShown)
            {
              if(formKey.currentState!.validate())
              {
                cubit.insertDataBase(
                  Title: titleController.text, 
                  time: timeController.text, 
                  date: dateController.text);
                // insertDataBase(
                // Title: titleController.text, 
                // time: timeController.text, 
                // date: dateController.text).then((value) {
                //   getDataFromDataBase(database).then((value){
                //     Navigator.pop(context);
                //     // setState((){
                //     //   isBottomSheetShown = false;
                //     //   tasks=value;});
                //        });
                //    });
              }
              
            }else{
              scaffoldKey.currentState!.showBottomSheet(
              (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defultFormField(
                          controller: titleController, 
                          type: TextInputType.text, 
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'titel must not be empity';
                            }
                            return null;
                          }, 
                          lable: 'task title', 
                          prefix: Icons.text_fields,
                          ),
                        SizedBox(height: 15.0,),
                        defultFormField(
                          controller: timeController, 
                          type: TextInputType.datetime, 
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'time must not be empity';
                            }
                            return null;
                          }, 
                          lable: 'task time', 
                          prefix: Icons.watch_later_rounded,
                          onTap: ()
                          {
                            showTimePicker(
                              context: context, 
                              initialTime: TimeOfDay.now(),
                              ).then((value) 
                              {
                                timeController.text = value!.format(context);
                                print(value.format(context));
                              });
                          },
                          ),
                        SizedBox(height: 15.0,),
                        defultFormField(
                          controller: dateController, 
                          type: TextInputType.datetime,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'date must not be empity';
                            }
                            return null;
                          }, 
                          lable: 'task date', 
                          prefix: Icons.calendar_today_outlined,
                          onTap: ()
                          {
                            showDatePicker(
                            context: context, 
                            initialDate: DateTime.now(), 
                            firstDate: DateTime.now(), 
                            lastDate: DateTime.parse('2022-09-30'),
                            ).then((value)
                            {
                              dateController.text = DateFormat.yMMMd().format(value!);
                              print(DateFormat.yMMMd().format(value));
                            }
                            );
                          },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
             elevation: 20.0,
             ).closed.then((value){
                cubit.isBottomSheetShown = false;
                cubit.ChangeBottomSheetState(isiconadd: false);
               });
               cubit.ChangeBottomSheetState(isiconadd: true);
            }
          },
          child: Icon(
            cubit.isBottomSheetShown? Icons.add :Icons.create_rounded,
            ),
            ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: AppCubit().get(context).currentIndex,
          onTap: (index){
            AppCubit().get(context).ChangeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon:Icon(
                Icons.menu,
              ),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon:Icon(
                Icons.check_circle_outline,
              ),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon:Icon(
                Icons.archive,
              ),
              label: 'Archived',
            ),
          ],
        ),
      );
        },
        ),
    );
  }
}

  Future<String> getName() async{
    return 'soad';
  }
  