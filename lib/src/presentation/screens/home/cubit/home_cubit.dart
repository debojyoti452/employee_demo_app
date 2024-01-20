import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/db/database_helper.dart';
import '../../../../data/model/employee_model.dart';
import '../../../../data/repository/employee_repository.dart';
import '../../../base/base_cubit_wrapper.dart';
import '../../../base/cubit_status.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

class HomeCubit extends BaseCubitWrapper<HomeState> {
  HomeCubit()
      : super(HomeState(
          appState: CubitStatus.initial(),
          employeeList: [],
        ));
  late EmployeeRepository _employeeRepository;

  @override
  void initialize() {
    _employeeRepository = injector.get<EmployeeRepository>();
  }

  Future<void> fetchEmployeeList() async {
    emit(state.copyWith(appState: CubitStatus.loading(event: 'employee_list_loading')));
    var res = await _employeeRepository.fetchEmployeeList();
    res.when(
      success: (data) {
        emit(state.copyWith(
          appState: CubitStatus.success(),
          employeeList: data,
        ));
      },
      failure: (message) {
        emit(state.copyWith(appState: CubitStatus.error(message: message)));
      },
    );
  }

  @override
  void dispose() {}

  void deleteEmployee(EmployeeModel employee) async {
    emit(state.copyWith(appState: CubitStatus.loading(event: 'employee_delete_loading')));
    if (employee.id == null) {
      emit(state.copyWith(appState: CubitStatus.error(message: 'Employee id is null')));
      return;
    }

    var res = await _employeeRepository.deleteEmployee(employee.id ?? -1);

    res.when(
      success: (data) {
        var employeeList = state.employeeList?.toList() ?? [];

        if (employeeList.isEmpty) {
          emit(state.copyWith(appState: CubitStatus.error(message: 'Employee list is empty')));
          return;
        }

        fetchEmployeeList();
      },
      failure: (message) {
        emit(state.copyWith(appState: CubitStatus.error(message: message)));
      },
    );
  }
}
