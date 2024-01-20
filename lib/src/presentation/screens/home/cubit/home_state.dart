part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required BaseCubitState appState,
    List<EmployeeItem>? employeeList,
  }) = _HomeState;
}
