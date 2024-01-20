import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/app_constants.dart';
import '../../../core/extension/context_ext.dart';
import '../../../core/extension/datetime_ext.dart';
import '../ui_widgets.dart';
import 'cubit/custom_calendar_cubit.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.onDateSelected,
  });

  final ValueChanged<DateTime?> onDateSelected;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late CustomCalendarCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<CustomCalendarCubit>();
    _cubit.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomCalendarCubit, CustomCalendarState>(
      bloc: _cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _topOptionBar(state),
                _buildCalendar(state),
                verticalDivider(color: context.theme.colorScheme.onSurface),
                _bottomActionBar(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bottomActionBar(CustomCalendarState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                  if (state.selectedDate != null)
                    TextSpan(
                      text: '  ${state.selectedDate?.formatDate(AppConstants.formattedDateWithMonthAndYear)}',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.theme.colorScheme.onPrimary,
                        fontSize: 14.sp,
                      ),
                    )
                  else
                    TextSpan(
                      text: '  No Date',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.theme.colorScheme.onPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                ],
              ),
            ),
          ),
          horizontalSpace(10),
          _belowButton(
            title: context.l10n.cancel,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _belowButton(
            title: context.l10n.save,
            onPressed: () {
              if (state.selectedDate == null) {
                BotToast.showText(
                  text: 'Please select a date',
                  textStyle: context.textTheme.labelMedium!.copyWith(
                    color: context.theme.colorScheme.primary,
                  ),
                  contentColor: context.theme.colorScheme.onSecondary,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                  duration: const Duration(seconds: 2),
                );
                return;
              }
              widget.onDateSelected(state.selectedDate);
              Navigator.of(context).pop();
            },
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(CustomCalendarState state) {
    // Generate the days of the week
    List<Widget> dayWidgets = [];
    List<String> daysOfWeek = state.daysOfWeek;
    DateTime currentDate = state.monthAndYear;

    for (var day in daysOfWeek) {
      dayWidgets.add(
        Expanded(
          child: Center(
            child: Text(
              day,
              style: context.textTheme.labelSmall,
            ),
          ),
        ),
      );
    }

    // Generate the days of the month
    int year = currentDate.year;
    int month = currentDate.month;
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int firstDayOfWeek = firstDayOfMonth.weekday;
    DateTime lastDayOfPreviousMonth = firstDayOfMonth.subtract(Duration(days: firstDayOfWeek));
    int daysInMonth = DateTime(year, month + 1, 0).day;

    // Generate the date widgets
    List<Widget> dateWidgets = [];

    // Add days from the previous month
    for (int i = 0; i < firstDayOfWeek; i++) {
      dateWidgets.add(Expanded(
        child: Container(),
      ));
    }

    dateWidgets = List.from(dateWidgets.reversed);

    // Add days of the current month
    for (int i = 1; i <= daysInMonth; i++) {
      dateWidgets.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              _cubit.selectDate(DateTime(year, month, i));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                  color: () {
                    if (state.selectedDate != null &&
                        state.selectedDate?.isSameDay(DateTime(year, month, i)) == true) {
                      return context.theme.colorScheme.secondary;
                    } else if (state.todayDate.isSameDay(DateTime(year, month, i))) {
                      return context.theme.colorScheme.primary;
                    } else {
                      return Colors.transparent;
                    }
                  }(),
                ),
                color: () {
                  if (state.selectedDate != null &&
                      state.selectedDate?.isSameDay(DateTime(year, month, i)) == true) {
                    return context.theme.colorScheme.primary;
                  } else if (state.todayDate.isSameDay(DateTime(year, month, i))) {
                    return Colors.transparent;
                  } else {
                    return Colors.transparent;
                  }
                }(),
              ),
              child: Text(
                '$i',
                style: context.textTheme.labelSmall?.copyWith(
                  color: () {
                    if (state.selectedDate != null &&
                        state.selectedDate?.isSameDay(DateTime(year, month, i)) == true) {
                      return context.theme.colorScheme.onSecondary;
                    } else if (state.todayDate.isSameDay(DateTime(year, month, i))) {
                      return context.theme.colorScheme.primary;
                    } else {
                      return context.theme.colorScheme.onPrimary;
                    }
                  }(),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Add days from the next month
    int remainingDays = 7 - dateWidgets.length % 7;
    if (remainingDays != 7) {
      DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
      for (int i = 0; i < remainingDays; i++) {
        dateWidgets.add(Expanded(child: Container()));
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.arrow_left_rounded, size: 30.w),
                  onPressed: () => _cubit.changeMonth(false),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    currentDate.formatCalendarMonthAndYear(),
                    style: context.textTheme.labelMedium,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.arrow_right_rounded, size: 30.w),
                  onPressed: () => _cubit.changeMonth(true),
                ),
              ),
            ],
          ),
          verticalSpace(10),
          Row(children: dayWidgets),
          verticalSpace(10),
          ...List.generate((dateWidgets.length / 7).ceil(), (index) {
            int start = index * 7;
            int end = (start + 7 > dateWidgets.length) ? dateWidgets.length : start + 7;
            return Row(children: dateWidgets.sublist(start, end));
          }),
          verticalSpace(20),
        ],
      ),
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

  Widget _topOptionBar(CustomCalendarState state) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 18.h, bottom: 8.h),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              _dateButton(
                onPressed: () {
                  _cubit.selectDate(DateTime.now());
                },
                title: context.l10n.today,
                selected: state.selectedDate != null
                    ? state.todayDate.isSameDay(state.selectedDate!)
                    : false,
              ),
              _dateButton(
                onPressed: () {
                  _cubit.selectDate(
                    state.todayDate.add(
                      Duration(days: (8 - state.todayDate.weekday) % 7),
                    ),
                  );
                },
                title: context.l10n.nextMonday,
                selected: state.todayDate.add(
                      Duration(days: (8 - state.todayDate.weekday) % 7),
                    ) ==
                    state.selectedDate,
              ),
            ],
          ),
          Row(
            children: [
              _dateButton(
                onPressed: () {
                  _cubit.selectDate(
                    state.todayDate.add(
                      Duration(days: (9 - state.todayDate.weekday) % 7),
                    ),
                  );
                },
                title: context.l10n.nextTuesday,
                selected: state.todayDate.add(
                      Duration(days: (9 - state.todayDate.weekday) % 7),
                    ) ==
                    state.selectedDate,
              ),
              _dateButton(
                onPressed: () {
                  _cubit.selectDate(
                    state.todayDate.add(
                      const Duration(days: 7),
                    ),
                  );
                },
                title: context.l10n.afterOneWeek,
                selected: state.todayDate.add(
                      const Duration(days: 7),
                    ) ==
                    state.selectedDate,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateButton({
    required String title,
    required VoidCallback onPressed,
    bool selected = false,
  }) {
    return Expanded(
      child: Container(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: selected
                  ? context.theme.colorScheme.primary
                  : context.theme.colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                title,
                style: context.textTheme.labelSmall?.copyWith(
                  color: () {
                    if (selected) {
                      return context.theme.colorScheme.onSecondary;
                    } else {
                      return context.theme.colorScheme.primary;
                    }
                  }(),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
