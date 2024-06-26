import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_10/database/db_functions.dart';
import 'package:sqflite_10/database/db_model.dart';
import 'package:sqflite_10/provider/provider_datacontroller.dart';
import 'package:sqflite_10/screen/editstudent.dart';
import 'package:sqflite_10/screen/studentdetails.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentdataProvider>(context, listen: true).intialize();
    return Consumer<StudentdataProvider>(
      builder: (BuildContext context, studentdata, child) {
         if (studentdata.studentList.isEmpty) {
        return const Center(
          child: Text(
            'No data found',
            style: TextStyle(fontSize: 16),
          ),
        );
      }else{
         return
       ListView.builder(
        itemCount: studentdata.studentList.length,
        itemBuilder: (context, index) {
          final student = studentdata.studentList[index];
          return Card(
            color: Colors.yellow[50],
            margin: const EdgeInsets.all(10),
            child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        File(student.imagex),
                      ),
                    ),
                    title: Text(student.name),
                    subtitle: Text(
                      "Class: ${student.classname}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditStudent(student: student),
                            ));
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deletestudent(context, student);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctr) => StudentDetails(stdetails: student),
                      ));
                    },
                  ),
          );
        },
      );
      }
     
     
       }
    );
  }

  void deletestudent(ctx, StudentModel student) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do You Want delete the list ?'),
          actions: [
            TextButton(
              onPressed: () {
                detectedYes(context, student);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void detectedYes(ctx, StudentModel student) {
    deleteStudent(student.id!, ctx);
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(ctx).pop();
  }
}
