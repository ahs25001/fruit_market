import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:get/get.dart' as getx;
class OrderDetailsItem extends StatefulWidget {
  CartModel? product;
  String? orderId;
  OrderDetailsItem({Key? key, required this.product, required this.orderId})
      : super(key: key);

  @override
  State<OrderDetailsItem> createState() => _OrderDetailsItemState();
}

class _OrderDetailsItemState extends State<OrderDetailsItem> {
  double? rating;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
       
            if (state.status == OrdersStatus.changeRatingSuccess ||
                state.status == OrdersStatus.changeRatingError) {
              getx.Get.back();
            } else if (state.status == OrdersStatus.changeRatingLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return PopScope(
                    canPop: false,
                    child: AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: FancyShimmerImage(
                  imageUrl: widget.product?.image ?? "",
                  width: 95.w,
                  height: 95.h,
                  boxFit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product?.name ?? "",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  StarRating(
                    rating: rating == null
                        ? (widget.product?.rating ?? 0).toDouble()
                        : rating!,
                    color: rateColor,
                    onRatingChanged: (rating) {
                      setState(() {
                        this.rating = rating;
                      });
                      context.read<OrdersCubit>().changeRating(
                          widget.product!, rating, widget.orderId ?? '');
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${widget.product?.price} EGP / kg",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
