import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/networks/local/cache_helper.dart';
import 'package:project_test/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/task_manager/archived_tasks.dart';
import '../../modules/task_manager/done_tasks.dart';
import '../../modules/task_manager/tasks.dart';




class Appcubit extends Cubit<Appstates>{


  Appcubit() : super(AppinitialState());

  static Appcubit get(context) => BlocProvider.of(context);


  Database? database;
  int currentIndex=0;
  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archivedTasks =[];

  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> Titles =[
    "Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  bool isBottomSheetShown = false;
  Icon floatingactionIcon = Icon(Icons.edit);




  void ChangeIndex(int index){

    currentIndex=index;
    emit(AppChangeBottomNavBarState());

  }




  void createDatabase() {

    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version)
        {
          print("DATABASE CREATED");
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
        },
        onOpen: (database)
        {
          getDataFromDatabase(database);
          print("DATABASE OPENED");
        }
    ).then((value) {

      database =value;
      emit(AppCreateDatabaseState());
    });

  }

  insertToDatabase(
      {
        required String name,
        required String time,
        required String date,
      }) async{

    return await database?.transaction((txn)
    {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$name", "$time", "$date", "New")'
      ).then((value)
      {
        print("INSERT SUCCESSFULL");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }
      ).catchError((error)
      {
        print("ERROR INSERTING NEW ROW");
      });
    });


  }


  void getDataFromDatabase(database) async{

    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());


    database!.rawQuery('SELECT * FROM tasks').then((value)
    {


      value.forEach((element) {

        if(element['status'] == 'New'){

          newTasks.add(element);
        }
        else if(element['status'] == 'done'){
          doneTasks.add(element);
        }
        else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });



  }


  void updateDatabase({
    required String status,
    required int id,
  }) async{

    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());

    });



  }




  void changeBottomSheetState({
    required bool isShow,
    required Icon icon
  })
  {

    isBottomSheetShown = isShow;
    floatingactionIcon = icon;

    emit(AppChangeBottomSheetState());

  }

  void deleteData({
    required int ? id,
})async 
  {
    database?.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value){
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }










  bool isDark = false;

  void ChangeThemeMode({bool ? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
    }else{
      isDark = !isDark;
    }
    CacheHelper.putData(key: 'isDark', value: isDark).then((value){
      emit(AppChangThemeState());
    });


  }

}

