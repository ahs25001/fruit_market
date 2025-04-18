import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';

/// ***********  ✨ Windsurf Command ⭐  ************
class FeatureDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.w),
        color: dividerColor,
        width: MediaQuery.sizeOf(context).width,
        height: 1.h,
      ),
    );
  }
}

/*******  bd09c1ce-be2d-4528-8388-778a50fa2d80  *******/