import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:get/get.dart' as getx;

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  ProductModel productModel;
  ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: InkWell(
            splashColor: Colors.transparent,
            onTap: () => getx.Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20.sp,
            )),
        title: Text(
          'Details'.toUpperCase(),
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      productModel.image ?? "",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 186.h,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    productModel.name ?? "",
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11.5.w),
                    child: Text(
                      productModel.description ?? "",
                      style:
                          TextStyle(fontSize: 12.sp, color: discriptionColor),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "Nutrition",
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 22.h,
                    ),
                    shrinkWrap: true,
                    itemCount: productModel.nutrition?.length ?? 0,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Row(
                      children: [
                        CircleAvatar(
                          radius: 4.r,
                          backgroundColor: discriptionColor,
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        Text(productModel.nutrition?[index] ?? "",
                            style: TextStyle(
                                fontSize: 12.sp, color: discriptionColor))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    "EGP ${productModel.price} Per/ kg",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.r, vertical: 11.r),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r))),
                      child: Text(
                        "Buy Now",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
