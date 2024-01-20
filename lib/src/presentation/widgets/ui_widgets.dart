import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpace(double height) {
  return SizedBox(
    height: height.h,
  );
}

SizedBox horizontalSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}

Widget verticalDivider({
  double? height = 1,
  Color? color = Colors.grey,
  double? width = double.infinity,
}) {
  return Container(
    height: height,
    width: width,
    color: color,
  );
}

Widget horizontalDivider(
  double width, {
  Color? color = Colors.grey,
}) {
  return Container(
    width: width.w,
    color: color,
  );
}
