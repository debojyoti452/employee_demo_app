import 'package:injectable/injectable.dart';

import '../../../remote/base/result_response.dart';
import '../../../remote/datasource/employee_remote_data_source.dart';
import '../../model/employee_model.dart';
import '../employee_repository.dart';

@Injectable(as: EmployeeRepository)
class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<EmployeeItem>, String>> fetchEmployeeList() async {
    try {
      final response = await remoteDataSource.fetchEmployeeList();
      if (response.hasError) {
        return Result(error: response.error);
      }

      if (response.hasNoData) {
        return Result(error: 'No data found');
      }

      if (response.response == null) {
        return Result(error: 'Something went wrong');
      }

      if (response.hasData) {
        var data = _sortHeaderAndData(response.response!);
        return Result(response: data);
      }

      return Result(error: 'Something went wrong');
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  List<EmployeeItem> _sortHeaderAndData(List<Map<String, dynamic>> value) {
    var employeeList = value.map((e) => EmployeeModel.fromJson(e)).toList();

    var sortedEmployeeList = <EmployeeItem>[];

    // if end date is null then add to current employee list
    var currentEmployeeList = employeeList.where((element) => element.endingDate == null).toList();

    // if end date is not null then add to past employee list
    var pastEmployeeList = employeeList.where((element) => element.endingDate != null).toList();

    // sort current employee list by joining date
    currentEmployeeList.sort((a, b) => a.joiningDate!.compareTo(b.joiningDate!));

    // sort past employee list by ending date
    pastEmployeeList.sort((a, b) => a.endingDate!.compareTo(b.endingDate!));

    // add header to current employee list if the list is not empty
    if (currentEmployeeList.isNotEmpty) {
      sortedEmployeeList.add(EmployeeHeaderItem('Current Employees'));
    }

    // add current employee list to sorted employee list
    sortedEmployeeList.addAll(currentEmployeeList.map((e) => EmployeeDataItem(e)));

    // add header to past employee list if the list is not empty
    if (pastEmployeeList.isNotEmpty) {
      sortedEmployeeList.add(EmployeeHeaderItem('Past Employees'));
    }

    // add past employee list to sorted employee list
    sortedEmployeeList.addAll(pastEmployeeList.map((e) => EmployeeDataItem(e)));

    return sortedEmployeeList;
  }

  @override
  Future<Result<int, String>> deleteEmployee(int id) async {
    try {
      final response = await remoteDataSource.deleteEmployee(id);
      if (response.hasError) {
        return Result(error: response.error);
      }

      if (response.hasNoData) {
        return Result(error: 'No data found');
      }

      if (response.response == null) {
        return Result(error: 'Something went wrong');
      }

      if (response.hasData) {
        return Result(response: response.response!);
      }

      return Result(error: 'Something went wrong');
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<int, String>> insertEmployee(EmployeeModel employee) async {
    try {
      final response = await remoteDataSource.insertEmployee(employee.toJson());
      if (response.hasError) {
        return Result(error: response.error);
      }

      if (response.hasNoData) {
        return Result(error: 'No data found');
      }

      if (response.response == null) {
        return Result(error: 'Something went wrong');
      }

      if (response.hasData) {
        return Result(response: response.response!);
      }

      return Result(error: 'Something went wrong');
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<int, String>> updateEmployee(EmployeeModel employee) async {
    try {
      if (employee.id == null) {
        return Result(error: 'Employee id is null');
      }

      final response = await remoteDataSource.updateEmployee(employee.toJson(), employee.id ?? -1);
      if (response.hasError) {
        return Result(error: response.error);
      }

      if (response.hasNoData) {
        return Result(error: 'No data found');
      }

      if (response.response == null) {
        return Result(error: 'Something went wrong');
      }

      if (response.hasData) {
        return Result(response: response.response!);
      }

      return Result(error: 'Something went wrong');
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
