import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_utils.dart';

class TextFormFieldCustomWidget extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputAction? inputAction;
  final Function(String value)? onChanged;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final bool? requiedText;
  final int maxLine;
  final bool? readOnly;

  const TextFormFieldCustomWidget({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.suffixIcon,
    this.onChanged,
    this.obscureText,
    this.inputAction,
    this.textInputType,
    this.validator,
    this.requiedText,
    this.maxLine = 1,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            requiedText ?? false
                ? const Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink()
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          keyboardType: textInputType,
          textInputAction: inputAction,
          validator: validator,
          maxLines: maxLine,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 15.h,
            ),
            suffixIcon: suffixIcon ?? const SizedBox(),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: ColorUtils.grayColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: ColorUtils.grayColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
