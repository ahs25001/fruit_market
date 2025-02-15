import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';

// ignore: must_be_immutable
class DataFormField extends StatelessWidget {
  TextEditingController controller;
  Function validator;
  bool isNumber;
  bool isAddress;
  String title;
  FocusNode focusNode;
  VoidCallback onSubmit;

  DataFormField(
      {super.key,
      required this.controller,
      required this.isAddress,
      required this.focusNode,
      required this.onSubmit,
      required this.title,
      required this.isNumber,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp),
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          cursorOpacityAnimates: true,
          onFieldSubmitted: (value) {
            onSubmit();
          },
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: borderColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: borderColor),
              )),
          maxLines: isAddress ? 5 : 1,
          keyboardType: isNumber?TextInputType.phone:TextInputType.text,
          focusNode: focusNode,
          validator: (value) {
            return validator(value);
          },
        ),
      ],
    );
  }
}
