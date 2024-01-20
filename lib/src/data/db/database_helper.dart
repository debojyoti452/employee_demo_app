import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/constant/app_constants.dart';

/// Database helper class
/// [Table name] employee
/// [Table columns] id, name, designation, joiningDate, leavingDate
class DatabaseHelper {
  late Database _database;

  final String table = 'employee';

  DatabaseHelper() {
    initialize();
  }

  Future<void> initialize() async {
    _database = await openDatabase(
      AppConstants.databaseName,
      version: AppConstants.databaseVersion,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE employee(id INTEGER PRIMARY KEY AUTOINCREMENT, employee_name TEXT NULL, designation TEXT NULL, joining_date TEXT NULL, ending_date TEXT NULL)',
        );
      },
    );
  }

  // insert, update, delete, select
  Future<int> insert(Map<String, dynamic> data) async {
    return await _database.insert(table, data);
  }

  Future<int> update(Map<String, dynamic> data, String where, List<dynamic> whereArgs) async {
    return await _database.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String where, List<dynamic> whereArgs) async {
    return await _database.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> select(String where, List<dynamic> whereArgs) async {
    return await _database.query(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> selectAll() async {
    return await _database.query(table);
  }

  Future<void> close() async {
    // await _database.close();
  }

  Future<void> dropTable(String table) async {
    await _database.execute('DROP TABLE $table');
  }

  Future<void> dropAllTable() async {
    await _database.execute('DROP TABLE employee');
  }

  Future<void> truncateTable(String table) async {
    await _database.execute('DELETE FROM $table');
  }
}
