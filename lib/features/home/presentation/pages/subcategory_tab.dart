import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/features/home/presentation/widgets/subcategory_item.dart';

class SubcategoryTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20.h,),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      // shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) =>   SubcategoryItem()
      ,
    );
  }
}