part of 'employee_details_cubit.dart';

@freezed
class EmployeeDetailsState with _$EmployeeDetailsState {
  factory EmployeeDetailsState({
    required BaseCubitState appState,
    required EmployeeModel employeeModel,
    required List<String> designationList,
  }) = _EmployeeDetailsState;
}
