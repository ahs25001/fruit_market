import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_json.dart';
import 'package:fruit_market/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:fruit_market/features/home/presentation/widgets/cart_item.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart' as getx;

class CartTab extends StatelessWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: primaryColor,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.white,
              ),
            )
          ],
        ),
        SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Shopping Cart",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            BlocSelector<HomeCubit, HomeState, num?>(
              selector: (state) {
                return state.totalPrice;
              },
              builder: (context, totalPrice) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => SizeTransition(
                      sizeFactor: animation, axis: Axis.vertical, child: child),
                  child: (totalPrice == null || totalPrice == 0)
                      ? SizedBox()
                      : SlideInDown(
                          duration: Duration(milliseconds: 300),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: borderColor,
                                  size: 20.sp,
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 161.w,
                                  child: Text(
                                    " 440001  Nagpur ,Maharashtra",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.black,
                                  size: 20.sp,
                                ),
                                Spacer(),
                                Text("Change Address",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12.sp,
                                    )),
                              ],
                            ),
                          ),
                        ),
                );
              },
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state.status == HomeStatus.placeOrderSuccess) {
                  getx.Get.showSnackbar(getx.GetSnackBar(
                    snackPosition: getx.SnackPosition.BOTTOM,
                    backgroundColor: primaryColor,
                    duration: Duration(seconds: 2),
                    message: "Order placed successfuly",
                  ));
                }
              },
              builder: (context, state) {
                return Expanded(
                    child: (state.favoriteProducts == null ||
                            state.cartProducts!.isEmpty)
                        ? Lottie.asset(emptyList)
                        : ListView(
                            children: [
                              ...state.cartProducts!.map((e) {
                                int currentIndex =
                                    state.cartProducts!.indexOf(e);
                                if (currentIndex == 0 ||
                                    e.categoryName !=
                                        state.cartProducts![currentIndex - 1]
                                            .categoryName) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 17.w),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7.h, horizontal: 20.w),
                                        color: Colors.grey.shade300,
                                        width: double.infinity,
                                        child: Text(
                                          e.categoryName ?? "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                      FadeInRight(
                                        duration: Duration(
                                            milliseconds:
                                                (currentIndex + 1) * 100),
                                        child: CartItem(
                                          onDelete: () {
                                            context
                                                .read<HomeCubit>()
                                                .removeProductFromCart(
                                                    e.id ?? "");
                                          },
                                          onInc: () {
                                            context
                                                .read<HomeCubit>()
                                                .incQuantityInCart(e);
                                          },
                                          onDec: () {
                                            context
                                                .read<HomeCubit>()
                                                .decQuantityInCart(e);
                                          },
                                          productModel: e,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return FadeInRight(
                                  duration: Duration(
                                      milliseconds: (currentIndex + 1) * 100),
                                  child: CartItem(
                                    onDelete: () {
                                      context
                                          .read<HomeCubit>()
                                          .removeProductFromCart(e.id ?? "");
                                    },
                                    onInc: () {
                                      context
                                          .read<HomeCubit>()
                                          .incQuantityInCart(e);
                                    },
                                    onDec: () {
                                      context
                                          .read<HomeCubit>()
                                          .decQuantityInCart(e);
                                    },
                                    productModel: e,
                                  ),
                                );
                              }),
                            ],
                          ));
              },
            ),
            BlocSelector<HomeCubit, HomeState, num?>(
              selector: (state) {
                return state.totalPrice;
              },
              builder: (context, totalPrice) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => SizeTransition(
                      sizeFactor: animation, axis: Axis.vertical, child: child),
                  child: (totalPrice == null || totalPrice == 0)
                      ? SizedBox()
                      : SlideInUp(
                          duration: Duration(milliseconds: 300),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text("Total : $totalPrice"),
                                Spacer(),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w, vertical: 10.h)),
                                    onPressed: () {
                                      context.read<HomeCubit>().placeOrder();
                                    },
                                    child: Text(
                                      "Place Order",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          ),
                        ),
                );
              },
            )
          ],
        ))
      ],
    );
  }
}
