import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constants.dart';
import '../../../core/extension/context_ext.dart';
import '../../../core/extension/datetime_ext.dart';
import '../../../data/model/employee_model.dart';
import '../../utils/theme/color_scheme.dart';
import '../ui_widgets.dart';

typedef DragDeleteCallback = void Function(DismissDirection direction, EmployeeModel employee);
class CustomHeaderListView extends StatelessWidget {
  const CustomHeaderListView({
    super.key,
    required this.employeeList,
    required this.onRefresh,
    required this.onDismissed,
    required this.onItemTapped,
  });

  final List<EmployeeItem> employeeList;

  final DragDeleteCallback onDismissed;

  final VoidCallback onRefresh;

  final ValueChanged<EmployeeModel> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: CustomScrollView(
        slivers: employeeList.map((item) {
          if (item is EmployeeHeaderItem) {
            return SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(item.header),
            );
          } else {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (item is EmployeeDataItem) {
                    var employee = item.employee;
                    return _itemView(employee);
                  } else {
                    return const SizedBox();
                  }
                },
                childCount: 1,
              ),
            );
          }
        }).toList(),
      ),
    );
  }

  Widget _itemView(EmployeeModel employee) {
    return Builder(builder: (context) {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onDismissed(direction, employee);
        },
        background: Container(
          color: context.theme.colorScheme.error,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(
              Icons.delete,
              color: context.theme.colorScheme.onError,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            onItemTapped(employee);
          },
          child: Container(
            width: context.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            margin: EdgeInsets.only(bottom: 2.h),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: context.theme.colorScheme.onSurface.withOpacity(0.1),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.employeeName ?? '',
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  employee.designation ?? '',
                  style: context.theme.textTheme.titleSmall?.copyWith(
                    color: AppColor.lightTextColor,
                    height: 1.8,
                  ),
                ),
                if (employee.endingDate == null)
                  Text(
                    'From ${employee.joiningDate!.formatDate(AppConstants.formattedDateWithMonthAndYear)}',
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      color: AppColor.lightTextColor,
                      height: 1.8,
                    ),
                  )
                else
                  Text(
                    '${employee.joiningDate!.formatDate(AppConstants.formattedDateWithMonthAndYear)} - ${employee.endingDate!.formatDate(AppConstants.formattedDateWithMonthAndYear)}',
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      color: AppColor.lightTextColor,
                      height: 1.8,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String header;

  _StickyHeaderDelegate(this.header);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        header,
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.theme.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  @override
  double get maxExtent =>
      header is PreferredSizeWidget ? (header as PreferredSizeWidget).preferredSize.height : 60;

  @override
  double get minExtent =>
      header is PreferredSizeWidget ? (header as PreferredSizeWidget).preferredSize.height : 60;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return oldDelegate.header != header;
  }
}
