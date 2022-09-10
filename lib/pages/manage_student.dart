import 'package:flutter/material.dart';
import 'package:learning_sqlite/controllers/sqlite_controller.dart';
import 'package:learning_sqlite/models/student_model.dart';
import 'package:learning_sqlite/pages/add_student.dart';
import 'package:learning_sqlite/pages/edit_student.dart';
import 'package:learning_sqlite/widgets/custom_text.dart';

class ManageStudent extends StatefulWidget {
  const ManageStudent({super.key});

  static const routeName = "manage_student";

  @override
  State<ManageStudent> createState() => _ManageStudentState();
}

class _ManageStudentState extends State<ManageStudent> {
  SQLiteController sqliteController = SQLiteController();
  late List<StudentModel> _students = [];

  @override
  void initState() {
    getStudentListFirstTime();
    super.initState();
  }

  void getStudentListFirstTime() async {
    await sqliteController.initializeDatabase();
    getStudentList();
  }

  void getStudentList() async {
    _students.clear();
    _students = await sqliteController.students();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quản lý sinh viên'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                _buildAddStudentRow(context),
                const Divider(thickness: 1),
                const SizedBox(height: 20),
                ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    StudentModel student = _students[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: _buildStudentItem(student),
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell _buildStudentItem(StudentModel student) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(
          EditStudent.routeName,
          arguments: student,
        );
        getStudentList();
        setState(() {});
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Card(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Tên: ${student.name}',
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: 'Địa chỉ: ${student.address}',
                        textColor: Colors.grey,
                      ),
                      CustomText(
                        text: 'Phone: ${student.phone}',
                        textColor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              sqliteController.deleteStudent(student.id);
              getStudentList();
              setState(() {});
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  InkWell _buildAddStudentRow(context) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(AddStudent.routeName);
        getStudentList();
        setState(() {});
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: const Icon(Icons.add, color: Colors.deepPurple),
          ),
          const SizedBox(width: 10),
          const CustomText(
            text: 'Thêm sinh viên mới',
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
