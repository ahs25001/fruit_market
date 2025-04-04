import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_images.dart';
import 'package:fruit_market/features/home/data/models/favorite_model.dart';

class FavoriteItem extends StatelessWidget {
  FavoriteModel? productModel;
  VoidCallback onInc;
  VoidCallback onDec;
  VoidCallback addToCart;
  VoidCallback removeFromCart;
  VoidCallback removeProductFromFavoriteList;
  bool isInCart;
  FavoriteItem(
      {required this.productModel,
      required this.removeProductFromFavoriteList,
      required this.onDec,
      required this.isInCart,
      required this.addToCart,
      required this.removeFromCart,
      required this.onInc,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10.r),
            onPressed: (context) {
              removeProductFromFavoriteList();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete From Favorite',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 2.w),
            borderRadius: BorderRadius.circular(10.r)),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
        child: Row(
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
                SizedBox(
                  width: 117.w,
                  child: Text(
                    productModel?.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
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
                        onTap: () {
                          onDec();
                        },
                        splashColor: slectedTabColor,
                        child: Container(
                          // margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 7.h),
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
                    Text("${productModel?.quntitiy ?? 1}"),
                    SizedBox(
                      width: 10.w,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          onInc();
                        },
                        splashColor: slectedTabColor,
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 7.h),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.r),
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
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30.h,
                ),
                (isInCart)
                    ? ElevatedButton(
                        onPressed: () {
                          removeFromCart();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            )),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))
                    : ElevatedButton(
                        onPressed: () {
                          addToCart();
                        },
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
        ),
      ),
    );
  }
}
