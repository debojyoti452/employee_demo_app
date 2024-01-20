import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/app_constants.dart';
import '../../../core/constant/ui_assets.dart';
import '../../../core/extension/context_ext.dart';
import '../../../core/extension/datetime_ext.dart';
import '../../base/base_state_wrapper.dart';
import '../../widgets/custom_list_view/custom_header_list_view.dart';
import '../../widgets/ui_widgets.dart';
import '../employee_details/add_employee_detail_screen.dart';
import '../employee_details/edit_employee_detail_screen.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home_screen';

  static const path = '/home_screen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStateWrapper<HomeScreen> {
  late HomeCubit _cubit;

  @override
  void onInit() {
    _cubit = context.read<HomeCubit>();
    _cubit.initialize();
    _cubit.fetchEmployeeList();
  }

  @override
  Widget onBuild(
    BuildContext context,
    BoxConstraints constraints,
    PlatformType platform,
  ) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: _cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.employeeList),
          ),
          body: () {
            if (state.employeeList == null || state.employeeList?.isEmpty == true) {
              return Center(
                child: SvgPicture.asset(
                  UiAssets.emptyRecord,
                  width: 260.w,
                  height: 244.h,
                ),
              );
            }

            return CustomHeaderListView(
              employeeList: state.employeeList ?? [],
              onRefresh: () {
                _cubit.fetchEmployeeList();
              },
              onDismissed: (direction, employee) {
                if (direction == DismissDirection.endToStart) {
                  _cubit.deleteEmployee(employee);
                  return;
                }
              },
              onItemTapped: (value) {
                context.pushNamed(EditEmployeeDetailScreen.name, extra: value);
              },
            );
          }(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: context.theme.colorScheme.primary,
            onPressed: () {
              context.pushNamed(AddEmployeeDetailScreen.name);
            },
            child: Icon(
              Icons.add,
              color: context.theme.colorScheme.secondary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            mini: true,
          ),
        );
      },
    );
  }

  @override
  void onDispose() {
    _cubit.dispose();
  }

  @override
  void onPause() {}

  @override
  void onResume() {
    _cubit.fetchEmployeeList();
  }
}
