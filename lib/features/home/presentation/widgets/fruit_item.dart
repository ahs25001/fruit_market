import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/products_details/presentation/pages/product_details_screen.dart';
import 'package:get/get.dart' as getx;

// ignore: must_be_immutable
class FruitItem extends StatelessWidget {
  bool isFavorite;
  FruitItem({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getx.Get.to(
            ProductDetailsScreen(
              productModel: ProductModel(
                categoryName: "Fruits",
                discription:
                    "Grapes will provide natural nutrients. The  Chemical in organic grapes which can be healthier hair and skin. It can be improve Your heart health. Protect your body from Cancer.",
                id: "",
                image: "assets/images/fru.jpg",
                name: "Grapes",
                nutrition: [
                  "Fiber",
                  "Potassium",
                  "Iron",
                  "Magnesium",
                  "Vitamin C",
                  "Vitamin K",
                  "Zinc",
                  "Phosphorous"
                ],
                price: "160",
                rating: 3.5,
              ),
            ),
            transition: getx.Transition.rightToLeftWithFade);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(17.r)),
                  child: Image.asset(
                    "assets/images/fru.jpg",
                    width: 118.w,
                    height: 143.h,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                right: 5.w,
                top: 7.h,
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: Colors.white,
                  child: AnimatedSwitcher(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    child: isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : SvgPicture.asset("assets/images/emty_hart.svg"),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          StarRating(
            allowHalfRating: true,
            rating: 3.5,
            color: rateColor,
            size: 20.sp,
          ),
          Text(
            "Strawberry",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 9.h,
          ),
          Text(
            "EGP 50 Per/kg",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
