import 'package:flutter/material.dart';
import 'pages/add_student.dart';
import 'pages/edit_student.dart';
import 'pages/manage_student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý sinh viên',
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: ManageStudent.routeName,
    );
  }

  Map<String, WidgetBuilder> get routes => {
        ManageStudent.routeName: (context) => const ManageStudent(),
        EditStudent.routeName: (context) => const EditStudent(),
        AddStudent.routeName: (context) => const AddStudent(),
      };
}
