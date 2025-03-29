import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_images.dart';

class FavoriteItem extends StatelessWidget {
  ProductModel? productModel;
  FavoriteItem({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: FancyShimmerImage(
            imageUrl: productModel?.image ?? "",
            width: 95.w,
            height: 95.h,
            boxFit: BoxFit.cover,
            errorWidget: Image.asset(
              errorImage,
              width: 95.w,
              height: 95.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productModel?.name ?? "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            StarRating(
              allowHalfRating: true,
              color: rateColor,
              size: 23.sp,
              rating: (productModel?.rating ?? 0.0).toDouble(),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {},
                    splashColor: slectedTabColor,
                    child: Container(
                      // margin: EdgeInsets.only(right: 10.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.r),
                        // border: bo
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text("1"),
                SizedBox(
                  width: 10.w,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    splashColor: slectedTabColor,
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.r),
                        // border: bo
                      ),
                      child: Icon(
                        Icons.add,
                        size: 20.sp,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Spacer(),
        Column(
          children: [
            Text(
              "${productModel?.price} Per/kg",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
           SizedBox(height: 30.h,),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: slectedTabColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    )),
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ))
          ],
        )
      ],
    );
  }
}
