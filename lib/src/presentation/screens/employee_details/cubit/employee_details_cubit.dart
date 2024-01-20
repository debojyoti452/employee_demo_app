import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../data/db/database_helper.dart';
import '../../../../data/model/employee_model.dart';
import '../../../../data/repository/employee_repository.dart';
import '../../../base/base_cubit_wrapper.dart';
import '../../../base/cubit_status.dart';

part 'employee_details_state.dart';

part 'employee_details_cubit.freezed.dart';

class EmployeeDetailsCubit extends BaseCubitWrapper<EmployeeDetailsState> {
  EmployeeDetailsCubit()
      : super(EmployeeDetailsState(
          appState: CubitStatus.initial(),
          employeeModel: EmployeeModel.empty(),
          designationList: AppConstants.designationList,
        ));

  late EmployeeRepository _employeeRepository;

  @override
  void initialize() {
    emit(state.copyWith(
      appState: CubitStatus.initial(event: 're-initialize'),
      employeeModel: EmployeeModel.empty(),
    ));
    _employeeRepository = injector.get<EmployeeRepository>();
  }

  void initialEmployeeItemModel(EmployeeModel employeeModel) {
    emit(state.copyWith(
      employeeModel: employeeModel,
    ));
  }

  @override
  void dispose() {}

  void updateJoiningDate(DateTime date) {
    emit(state.copyWith(
      employeeModel: state.employeeModel.copyWith(
        joiningDate: date,
      ),
    ));
  }

  void updateEndDate(DateTime date) {
    emit(state.copyWith(
      employeeModel: state.employeeModel.copyWith(
        endingDate: date,
      ),
    ));
  }

  void updateDesignation(int index) {
    emit(state.copyWith(
      employeeModel: state.employeeModel.copyWith(
        designation: state.designationList[index],
      ),
    ));
  }

  Future<void> saveEmployee() async {
    emit(state.copyWith(
      appState: CubitStatus.loading(event: 'save_employee'),
    ));
    var res = await _employeeRepository.insertEmployee(state.employeeModel);
    res.when(
      success: (data) {
        emit(state.copyWith(
          appState: CubitStatus.success(event: 'save_employee'),
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          appState: CubitStatus.error(event: 'save_employee', message: error),
        ));
      },
    );
  }

  void updateEmployeeName(String value) {
    emit(state.copyWith(
      employeeModel: state.employeeModel.copyWith(
        employeeName: value,
      ),
    ));
  }

  void updateEmployee() async {
    emit(state.copyWith(
      appState: CubitStatus.loading(event: 'update_employee'),
    ));
    var res = await _employeeRepository.updateEmployee(state.employeeModel);

    res.when(
      success: (data) {
        emit(state.copyWith(
          appState: CubitStatus.success(event: 'update_employee'),
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          appState: CubitStatus.error(event: 'update_employee', message: error),
        ));
      },
    );
  }

  void deleteEmployee() async {
    emit(state.copyWith(
      appState: CubitStatus.loading(event: 'delete_employee'),
    ));

    if (state.employeeModel.id == null) {
      emit(state.copyWith(
        appState: CubitStatus.error(event: 'delete_employee', message: 'Employee id is null'),
      ));
      return;
    }

    var res = await _employeeRepository.deleteEmployee(state.employeeModel.id ?? -1);
    res.when(
      success: (data) {
        emit(state.copyWith(
          appState: CubitStatus.success(event: 'delete_employee'),
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          appState: CubitStatus.error(event: 'delete_employee', message: error),
        ));
      },
    );
  }
}
