import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../core/extension/datetime_ext.dart';
import '../../../base/base_cubit_wrapper.dart';
import '../../../base/cubit_status.dart';

part 'custom_calendar_state.dart';

part 'custom_calendar_cubit.freezed.dart';

class CustomCalendarCubit extends BaseCubitWrapper<CustomCalendarState> {
  CustomCalendarCubit()
      : super(CustomCalendarState(
          appState: CubitStatus.initial(),
          daysOfWeek: AppConstants.daysOfWeek,
          monthAndYear: DateTime.now(),
          todayDate: DateTime.now(),
        ));

  @override
  void initialize() {
    emit(state.copyWith(
      appState: CubitStatus.initial(event: 're-initialize'),
      daysOfWeek: AppConstants.daysOfWeek,
      monthAndYear: DateTime.now(),
      todayDate: DateTime.now(),
      selectedDate: null,
    ));
  }

  void changeMonth(bool next) {
    emit(state.copyWith(
      appState: CubitStatus.loading(event: 'change_month'),
    ));
    var currentDate = state.monthAndYear;
    if (next) {
      currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
    } else {
      currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
    }
    emit(state.copyWith(
      monthAndYear: currentDate,
      appState: CubitStatus.loaded(event: 'change_month'),
    ));
  }

  @override
  void dispose() {}

  void selectDate(DateTime dateTime) {
    emit(state.copyWith(
      appState: CubitStatus.loaded(event: 'select_date'),
      selectedDate: dateTime,
    ));
  }
}
