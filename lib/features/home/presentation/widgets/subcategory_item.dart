import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/home/presentation/widgets/fruit_item.dart';

class SubcategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            "Organic Fruits",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            "(20% Off)",
            style: TextStyle(
                fontSize: 14.sp,
                color: primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        "Pick up from organic farms",
        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
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
          itemBuilder: (context, index) => FruitItem(isFavorite: index % 2 == 0,),
          itemCount: 10,
        ),
      )
    ]);
  }
}
