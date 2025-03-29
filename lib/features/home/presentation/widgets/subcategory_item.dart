import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/home/presentation/widgets/fruit_item.dart';

// ignore: must_be_immutable
class SubcategoryItem extends StatelessWidget {
  SubCategoryModel? subCategoryModel;
  SubcategoryItem(this.subCategoryModel);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            subCategoryModel?.name ?? "",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20.w,
          ),
          (subCategoryModel?.discounts == null)
              ? SizedBox()
              : Text(
                  "(${subCategoryModel!.discounts}% Off)",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w600),
                ),
        ],
      ),
    
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        height: 240.h,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 20.w,
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => FruitItem(
            productModel: subCategoryModel?.products?[index],
            isFavorite: index % 2 == 0,
          ),
          itemCount: subCategoryModel?.products?.length??0,
        ),
      )
    ]);
  }
}
