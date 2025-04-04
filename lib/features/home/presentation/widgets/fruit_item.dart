import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/products_details/presentation/pages/product_details_screen.dart';
import 'package:get/get.dart' as getx;
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

// ignore: must_be_immutable
class FruitItem extends StatelessWidget {
  bool isFavorite;
  bool isInCart;
  ProductModel? productModel;
  Function addProductToFavorite;
  Function removeProductFromFavorite;
  FruitItem(
      {super.key,
      required this.isFavorite,
      required this.isInCart,
      required this.removeProductFromFavorite,
      required this.productModel,
      required this.addProductToFavorite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getx.Get.to(() => ProductDetailsScreen(productModel: productModel,isInCart: isInCart,),
            transition: getx.Transition.rightToLeftWithFade);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Hero(
                tag: productModel?.image ?? "",
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(17.r)),
                    child: FancyShimmerImage(
                      imageUrl: productModel?.image ?? "",
                      width: 118.w,
                      height: 143.h,
                      boxFit: BoxFit.cover,
                    )),
              ),
              Positioned(
                right: 5.w,
                top: 7.h,
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: Colors.white,
                  child: isFavorite
                      ? InkWell(
                          onTap: () {
                            removeProductFromFavorite();
                          },
                          child: ElasticIn(
                            curve: Curves.elasticOut,
                            duration: Duration(milliseconds: 600),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            addProductToFavorite();
                          },
                          child: SvgPicture.asset(
                              "assets/images/emty_hart.svg")),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          StarRating(
            allowHalfRating: true,
            rating: (productModel?.rating ?? 0).toDouble(),
            color: rateColor,
            size: 20.sp,
          ),
          Text(
            productModel?.name ?? "",
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
            "EGP ${productModel?.price ?? "0"} Per/kg",
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
