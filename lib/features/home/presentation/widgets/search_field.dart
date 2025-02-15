import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.4),
            blurRadius: 10.r,
          )
        ],
      ),
      height: 40.h,
      width: 335.w,
      child: TextFormField(
          cursorOpacityAnimates: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: borderColor),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
            hintText: "Search ",
          )),
    );
  }
}
