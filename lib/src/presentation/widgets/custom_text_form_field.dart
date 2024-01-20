import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/extension/context_ext.dart';
import '../utils/theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  final String initialValue;

  const CustomTextFormField({
    super.key,
    this.initialValue = '',
    required this.hintText,
    required this.prefixIcon,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        autofocus: true,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          prefixIcon: Icon(
            prefixIcon,
            color: context.theme.colorScheme.primary,
            size: 20.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: context.theme.appColors.onSurface,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: context.theme.appColors.onSurface,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: context.theme.appColors.onSurface,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: context.theme.appColors.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: context.theme.appColors.error,
              width: 2,
            ),
          ),
          errorStyle: context.textTheme.labelSmall?.copyWith(
            color: context.theme.appColors.error,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        style: context.textTheme.labelSmall?.copyWith(
          color: context.theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
