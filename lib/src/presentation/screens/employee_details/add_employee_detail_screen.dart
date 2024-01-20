import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/app_constants.dart';
import '../../../core/extension/context_ext.dart';
import '../../../core/extension/datetime_ext.dart';
import '../../base/base_state_wrapper.dart';
import '../../base/cubit_status.dart';
import '../../widgets/custom_calendar/custom_date_picker.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/ui_widgets.dart';
import '../home/cubit/home_cubit.dart';
import 'cubit/employee_details_cubit.dart';

enum DatePickerType {
  startDate,
  endDate,
}

class AddEmployeeDetailScreen extends StatefulWidget {
  static const name = 'add_employee_detail_screen';

  static const path = '/add_employee_detail_screen';

  const AddEmployeeDetailScreen({super.key});

  @override
  _AddEmployeeDetailScreenState createState() => _AddEmployeeDetailScreenState();
}

class _AddEmployeeDetailScreenState extends BaseStateWrapper<AddEmployeeDetailScreen> {
  late EmployeeDetailsCubit _cubit;

  @override
  void onInit() {
    _cubit = context.read<EmployeeDetailsCubit>();
    _cubit.initialize();
  }

  @override
  Widget onBuild(
    BuildContext context,
    BoxConstraints constraints,
    PlatformType platform,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.addEmployee),
        ),
        body: BlocConsumer<EmployeeDetailsCubit, EmployeeDetailsState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state.appState is CubitSuccess) {
              var status = state.appState as CubitSuccess;
              if (status.event == 'save_employee') {
                context.read<HomeCubit>().fetchEmployeeList();
                context.pop();
              }
            }

            if (state.appState is CubitLoading) {
              var status = state.appState as CubitLoading;
              if (status.event == 'save_employee') {
                showLoading();
              }
            } else {
              hideLoading();
            }
          },
          builder: (context, state) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(24),
                  CustomTextFormField(
                    hintText: 'Employee name',
                    prefixIcon: Icons.person_2_outlined,
                    onChanged: (value) {
                      _cubit.updateEmployeeName(value);
                    },
                  ),
                  verticalSpace(20),
                  _designationView(state),
                  verticalSpace(20),
                  _dateView(state),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: SizedBox(
          height: 80.h,
          child: Column(
            children: [
              verticalDivider(color: context.theme.colorScheme.onSurface),
              verticalSpace(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _belowButton(
                    title: context.l10n.cancel,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  _belowButton(
                    title: context.l10n.save,
                    onPressed: () {
                      if (_cubit.state.employeeModel.employeeName == null) {
                        showToast('Please enter employee name');
                        return;
                      }

                      if (_cubit.state.employeeModel.designation == null) {
                        showToast('Please select designation');
                        return;
                      }

                      if (_cubit.state.employeeModel.joiningDate == null) {
                        showToast('Please select joining date');
                        return;
                      }

                      _cubit.saveEmployee();
                    },
                    isPrimary: true,
                  ),
                  horizontalSpace(8),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _designationView(EmployeeDetailsState state) {
    return _borderView(
      GestureDetector(
        onTap: () {
          // hide keyboard
          FocusScope.of(context).unfocus();

          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            builder: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _cubit.updateDesignation(index);
                      Navigator.pop(context);
                    },
                    title: Center(
                      child: Text(
                        state.designationList[index],
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    dense: true,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: context.theme.colorScheme.onSurface,
                  );
                },
                itemCount: state.designationList.length,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Icon(
              Icons.work_outline,
              color: context.theme.colorScheme.primary,
              size: 20.w,
            ),
            horizontalSpace(14),
            Expanded(
              child: Text(
                () {
                  if (state.employeeModel.designation == null) {
                    return 'Select Role';
                  } else {
                    return state.employeeModel.designation!;
                  }
                }(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.theme.colorScheme.onPrimary,
                ),
              ),
            ),
            horizontalSpace(8),
            Icon(
              Icons.arrow_drop_down,
              color: context.theme.colorScheme.primary,
              size: 22.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _borderView(Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.onSurface),
        borderRadius: BorderRadius.circular(4.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: child,
    );
  }

  Widget _dateView(EmployeeDetailsState state) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _openDatePicker(type: DatePickerType.startDate);
            },
            child: _borderView(
              Row(
                children: [
                  Icon(
                    Icons.event,
                    color: context.theme.colorScheme.primary,
                    size: 20.w,
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: Text(
                      () {
                        if (state.employeeModel.joiningDate == null) {
                          return 'No Date';
                        } else {
                          return state.employeeModel.joiningDate!.formatDate(
                            AppConstants.formattedDateWithMonthAndYear,
                          );
                        }
                      }(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  horizontalSpace(8),
                ],
              ),
            ),
          ),
        ),
        horizontalSpace(10),
        Center(
          child: Icon(
            Icons.arrow_right_alt,
            color: context.theme.colorScheme.primary,
            size: 20.w,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _openDatePicker(type: DatePickerType.endDate);
            },
            child: _borderView(
              Row(
                children: [
                  Icon(
                    Icons.event,
                    color: context.theme.colorScheme.primary,
                    size: 20.w,
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: Text(
                      () {
                        if (state.employeeModel.endingDate == null) {
                          return 'No Date';
                        } else {
                          return state.employeeModel.endingDate!.formatDate(
                            AppConstants.formattedDateWithMonthAndYear,
                          );
                        }
                      }(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  horizontalSpace(8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _belowButton({
    required String title,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return Container(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color:
                isPrimary ? context.theme.colorScheme.primary : context.theme.colorScheme.secondary,
          ),
          child: Center(
            child: Text(
              title,
              style: context.textTheme.labelSmall?.copyWith(
                color: isPrimary
                    ? context.theme.colorScheme.onSecondary
                    : context.theme.colorScheme.primary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onDispose() {
    _cubit.dispose();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  void _openDatePicker({required DatePickerType type}) {
    // hide keyboard
    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: CustomDatePicker(
          onDateSelected: (date) {
            if (date == null) {
              showToast('Please select date');
              return;
            }

            if (type == DatePickerType.startDate) {
              _cubit.updateJoiningDate(date);
            } else {
              _cubit.updateEndDate(date);
            }
          },
        ),
      ),
    );
  }
}
