import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/products_details/presentation/cubit/product_details_cubit.dart';
import 'package:get/get.dart' as getx;

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  ProductModel? productModel;
  bool isInCart;
  ProductDetailsScreen(
      {Key? key, required this.isInCart, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: Scaffold(
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
                    Hero(
                      tag: productModel?.image ?? "",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: FancyShimmerImage(
                          imageUrl: productModel?.image ?? "",
                          boxFit: BoxFit.cover,
                          width: double.infinity,
                          height: 186.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      productModel?.name ?? "",
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 11.5.w),
                      child: Text(
                        productModel?.description ?? "",
                        style:
                            TextStyle(fontSize: 12.sp, color: discriptionColor),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "Nutrition",
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 22.h,
                      ),
                      shrinkWrap: true,
                      itemCount: productModel?.nutrition?.length ?? 0,
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
                          Text(productModel?.nutrition?[index] ?? "",
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
                child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
                  listener: (context, state) {
                    if (state.status ==
                        ProductDetailsStatus.addProductToCartSuccess) {
                      getx.Get.back();
                      isInCart = true;
                      getx.Get.showSnackbar(getx.GetSnackBar(
                        backgroundColor: primaryColor,
                        duration: Duration(seconds: 1),
                        message: "Product added to cart successfuly",
                      ));
                    }else if (state.status ==
                        ProductDetailsStatus.removeProductFromCartSuccess){
                              getx.Get.back();
                          isInCart = false;
                          getx.Get.showSnackbar(getx.GetSnackBar(
                            backgroundColor: primaryColor,
                            duration: Duration(seconds: 1),
                            message: "Product removed from cart successfuly",
                          ));

                    } else if (state.status == ProductDetailsStatus.error) {
                      getx.Get.back();
                      // isInCart = true;
                      getx.Get.showSnackbar(getx.GetSnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                        message: "Something is wrong!",
                      ));
                    } else if (state.status == ProductDetailsStatus.loading) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => PopScope(
                          canPop: false,
                          child: AlertDialog(
                            content: Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          "EGP ${productModel?.price} Per/ kg",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        isInCart
                            ? ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ProductDetailsCubit>().removeProductfromCart(
                                          productModel?.id ?? "");
                                      
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.r, vertical: 11.r),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r))),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ))
                            : ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ProductDetailsCubit>()
                                      .addProductToCart(CartModel(
                                          categoryName:
                                              productModel?.categoryName,
                                          id: productModel?.id,
                                          image: productModel?.image,
                                          name: productModel?.name,
                                          price: productModel?.price,
                                          quntitiy: 1,
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.r, vertical: 11.r),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r))),
                                child: Text(
                                  "Buy Now",
                                  style: TextStyle(color: Colors.white),
                                ))
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
