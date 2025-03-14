import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';

// ignore: must_be_immutable
class InputDataField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  bool isDecription;
  bool isNumber;
  bool? isMultiLine;
  FocusNode focusNode;
  VoidCallback onSubmit;
  // Function validator;
  InputDataField({
    super.key,
    // required this.validator,
    required this.onSubmit,
    required this.hint,
    required this.focusNode,
    this.isMultiLine,
    required this.controller,
    required this.isDecription,
    required this.isNumber,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber
          ? TextInputType.number
          : isMultiLine ?? false
              ? TextInputType.multiline
              : TextInputType.text,
      cursorOpacityAnimates: true,
      controller: controller,
      focusNode: focusNode,
      validator: (value) => value!.isEmpty ? "$hint is requred":null,
      onFieldSubmitted: (value) => onSubmit(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: borderColor),
        ),
        hintText: hint,
      ),
      maxLines: isDecription ? 6 : 1,
    );
  }
}
