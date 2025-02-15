import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/models/category_model.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  bool isSlected;
  CategoryItem(
      {super.key, required this.categoryModel, required this.isSlected});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: isSlected
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: slectedTabColor,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: borderColor)),
              child: Text(categoryModel.name,
                  style: TextStyle(fontSize: 14.sp, color: Colors.white)),
            )
          : Text(
              categoryModel.name,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
    );
  }
}
