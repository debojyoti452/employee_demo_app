import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../data/db/database_helper.dart';
import '../base/result_response.dart';

@injectable
class EmployeeRemoteDataSource {
  final DatabaseHelper _databaseHelper;

  EmployeeRemoteDataSource(this._databaseHelper);

  // Fetch employee list
  Future<Result<List<Map<String, dynamic>>, String>> fetchEmployeeList() async {
    try {
      final response = await _databaseHelper.selectAll();
      return Result(response: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  // Delete employee
  Future<Result<int, String>> deleteEmployee(int id) async {
    try {
      final response = await _databaseHelper.delete('id = ?', [id]);
      return Result(response: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  // Insert employee
  Future<Result<int, String>> insertEmployee(Map<String, dynamic> employee) async {
    try {
      final response = await _databaseHelper.insert(employee);
      return Result(response: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  // Update employee
  Future<Result<int, String>> updateEmployee(Map<String, dynamic> employee, int id) async {
    try {
      final response = await _databaseHelper.update(employee, 'id = ?', [id]);
      return Result(response: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
