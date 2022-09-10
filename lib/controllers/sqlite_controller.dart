import 'package:flutter/material.dart';
import 'package:learning_sqlite/models/student_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Database database;
const DB_NAME = 'student_database.db'; // ignore: constant_identifier_names
const TABLE_NAME = 'student'; // ignore: constant_identifier_names

class SQLiteController {
  Future<void> initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
    );

    database.execute(
      'CREATE TABLE IF NOT EXISTS $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT,name Text, address Text, phone INTEGER)',
    );
  }

  Future<void> insertStudent(StudentModel student) async {
    await database.rawInsert(
      'INSERT INTO $TABLE_NAME (NAME,ADDRESS,PHONE) VALUES(\'${student.name}\',\'${student.address}\',${student.phone})',
    );
  }

  Future<List<StudentModel>> students() async {
    final List<Map<String, dynamic>> map =
        await database.rawQuery('SELECT * FROM $TABLE_NAME');

    return List.generate(map.length, (index) {
      Map<String, dynamic> studentMap = map[index];
      return StudentModel(
        id: studentMap['id'],
        name: studentMap['name'],
        address: studentMap['address'],
        phone: studentMap['phone'],
      );
    });
  }

  Future<void> updateStudent(StudentModel student) async {
    await database.update(
      TABLE_NAME,
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
    print(student.toMap());
  }

  Future<void> deleteStudent(int? id) async {
    await database.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
