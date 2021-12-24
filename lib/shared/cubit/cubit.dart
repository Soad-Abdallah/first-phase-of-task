import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:fristapp/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:fristapp/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:fristapp/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppIntailState());
  AppCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
 
  List<Widget>Screens=[
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];
  List<String>titels=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(index){
    currentIndex =index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map>Newtasks=[];
  List<Map>Donetasks=[];
  List<Map>Archivedtasks=[];

  void creatDataBase(){
     openDatabase(
      'todo2.db',
      version: 1,
      onCreate: (database,version){
        print('database created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, titel TEXT, data TEXT,time TEXT, status TEXT)').then((value)
        {
          print('table craeted');
        }).catchError((Error)
        {
          print('erroe when creating table ${Error.toString()}');
        });
        },
      onOpen: (database)
        {
          getDataFromDataBase(database);
          print('data opened');
        },
    ).then((value) => 
    {
      database=value,
      emit(AppCreatDataBaseState()),
    });
    }
  
  insertDataBase({
    required Title,
    required time,
    required date,
  }) async{
    await database.transaction((txn)
    {
      txn.rawInsert('INSERT INTO tasks(titel,data,time,status) VALUES("$Title","$date","$time","new")',
      ).then((value)
      {
        print('$value inserted succuffly');
        emit(AppInsertDataBaseState());

        getDataFromDataBase(database);
      }).catchError((Error)
      {
        print('erroe when creating table ${Error.toString()}');
      });
      return null;
    });
   }
  
  getDataFromDataBase(database) {
    Newtasks=[];
    Donetasks=[];
    Archivedtasks=[];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value){
      value.forEach((Element){
        print(Element['status']);
        if(Element['status'] == 'new')
        {
          Newtasks.add(Element);
        }else if (Element['status'] == 'done')
        {
          Donetasks.add(Element);
        }else 
        {
          Archivedtasks.add(Element);
        }
      });
      emit(AppGetDataBaseState());
    });  
  }

  void UpdateData({
    required String status,
    required int id, 
  }) async {
    await database.rawUpdate(
    'UPDATE tasks SET status = ? WHERE id = ?',
    ['$status',id],).then((value) 
    {
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }
  
   void deleteData({
    required int id, 
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', 
    [id]).then((value) 
    {
      getDataFromDataBase(database);
      emit(AppDeletDataBaseState());
    });
    }
  
  bool isBottomSheetShown = false;
  bool isiconadd =true;

  void ChangeBottomSheetState({
    required bool isiconadd,
  })
  {
    isBottomSheetShown = isiconadd;
    emit(AppChangeBottomSheetState());
  }
  
  bool IsDark =false;
  void ChangeAppMode(){
    IsDark =!IsDark;
    emit(AppChangeModeState());
  }
}