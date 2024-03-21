import 'package:flutter/material.dart';
import 'package:sqflite_10/database/db_functions.dart';
import 'package:sqflite_10/database/db_model.dart';

class StudentdataProvider extends ChangeNotifier {
  List<StudentModel> studentList = <StudentModel>[];
  List<StudentModel> filterStudent = <StudentModel>[];
  intialize() async {
    dynamic data =await getstudentdata();
    studentList =  data;
    notifyListeners();
  }

  getsearchdata(String query) async {
    await intialize();
    if (query.isEmpty) {
      filterStudent = studentList;
    } else {
      List<StudentModel> s = studentList
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()) ||
              element.classname.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filterStudent = s;
      
    }
    notifyListeners();
  }
}
