import '../../remote/base/result_response.dart';
import '../model/employee_model.dart';

abstract class EmployeeRepository {
  Future<Result<List<EmployeeItem>, String>> fetchEmployeeList();

  Future<Result<int, String>> deleteEmployee(int id);

  Future<Result<int, String>> insertEmployee(EmployeeModel employee);

  Future<Result<int, String>> updateEmployee(EmployeeModel employee);
}
