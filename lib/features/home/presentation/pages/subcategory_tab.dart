import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/home/presentation/widgets/subcategory_item.dart';

// ignore: must_be_immutable
class SubcategoryTab extends StatelessWidget{
  List<SubCategoryModel?>?subcategories;
   SubcategoryTab(this.subcategories, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20.h,),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      // shrinkWrap: true,
      itemCount: subcategories?.length??0,
      itemBuilder: (context, index) =>   SubcategoryItem(subcategories?[index])
      ,
    );
  }
}