import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/model/task.dart';

import '../firebase_utils.dart';

class AppConfigProvider extends ChangeNotifier{
  List<Task>taskList =[];
  DateTime selectedData =DateTime.now();

  String appLanguage = 'en' ;
  ThemeMode appTheme = ThemeMode.light;

  void changeLanguage(String newLanguge){
    if(appLanguage == newLanguge){
      return ;
    }
    appLanguage = newLanguge;
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode){
    if(appTheme == newMode){
      return ;
    }
    appTheme = newMode ;
    notifyListeners();
  }

  bool isDarkMode(){
    return appTheme == ThemeMode.dark;
    }
  void getAllTasksFireStore()async{
    QuerySnapshot<Task>  querySnapshot=await FirebaseUtils.getTaskCollection().get();
    taskList= querySnapshot.docs.map((doc) {
      return  doc.data();
    }).toList();
     taskList= taskList.where((task) {
      if(selectedData.day==task.dateTime!.day &&
      selectedData.month==task.dateTime!.month &&
      selectedData.year==task.dateTime!.year){
        return true;
      }
      return false;
    }).toList();
     taskList.sort((Task task1, Task task2){
       return task1.dateTime!.compareTo(task2.dateTime!);
       
     });
    notifyListeners();

  }
  void changsesSelectedDate(DateTime newSelectedDate){
    selectedData =newSelectedDate;
    getAllTasksFireStore();

}

}