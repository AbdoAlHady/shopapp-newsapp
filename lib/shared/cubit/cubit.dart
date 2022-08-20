import 'package:bloc/bloc.dart';
import 'package:bmicalc/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/todo_app/archived_tasks/archived_tasks.dart';
import '../../modules/todo_app/done_tasks/done_tasks.dart';
import '../../modules/todo_app/new_tasks/tasks_screen.dart';
import '../networks/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  late Database database;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScrees(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = ["New Tasks", "Done Tasks", "Archived Tasks"];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  //data base
  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
      print("db created");
    }, onOpen: (db) {
      getDataFromDataBase(db);
      print("db open");
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  updateDataBase({required String status, required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  delteDataBase({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDleteDataBaseState());
    });
  }

  insertToDataBase(
      {required String title,
      required String time,
      required String date}) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print("$value inserted successfuly");
        emit(AppInserDataBaseState());

        getDataFromDataBase(database);
      }).catchError((error) {
        print("Error when inserted new Record ${error.toString()}");
      });
    });
  }

  getDataFromDataBase(db) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDataBaseLoadingState());
    db.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDataBaseState());
    });
  }

  void changeBottomShettState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppModeThemState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark)
          .then((value) => emit(AppModeThemState()));
    }

  }
}
