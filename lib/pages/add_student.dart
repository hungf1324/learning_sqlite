import 'package:flutter/material.dart';
import 'package:learning_sqlite/components/student_form.dart';
import 'package:learning_sqlite/controllers/sqlite_controller.dart';
import 'package:learning_sqlite/models/student_model.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  static const routeName = "add_student";

  @override
  Widget build(BuildContext context) {
    SQLiteController sqliteController = SQLiteController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Thêm sinh viên'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: StudentForm(
          nameController: nameController,
          addressController: addressController,
          phoneController: phoneController,
          onPressed: () {
            sqliteController.insertStudent(
              StudentModel(
                name: nameController.text,
                address: addressController.text,
                phone: phoneController.text,
              ),
            );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
