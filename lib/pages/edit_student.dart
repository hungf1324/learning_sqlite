import 'package:flutter/material.dart';
import 'package:learning_sqlite/components/student_form.dart';
import 'package:learning_sqlite/controllers/sqlite_controller.dart';
import 'package:learning_sqlite/models/student_model.dart';

class EditStudent extends StatelessWidget {
  const EditStudent({super.key});

  static const routeName = "edit_student";

  @override
  Widget build(BuildContext context) {
    final student = ModalRoute.of(context)?.settings.arguments as StudentModel;
    SQLiteController sqliteController = SQLiteController();
    final TextEditingController nameController = TextEditingController(
      text: student.name,
    );
    final TextEditingController addressController = TextEditingController(
      text: student.address,
    );
    final TextEditingController phoneController = TextEditingController(
      text: student.phone.toString(),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chỉnh sửa sinh viên'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: StudentForm(
          nameController: nameController,
          addressController: addressController,
          phoneController: phoneController,
          onPressed: () {
            sqliteController.updateStudent(student);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
