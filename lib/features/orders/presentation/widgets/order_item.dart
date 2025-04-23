import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';
import 'package:fruit_market/features/orders/presentation/pages/order_details.dart';
import 'package:get/get.dart' as getx;

class OrderItem extends StatelessWidget {
  OrderModel? orderModel;
  OrderItem({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: InkWell(
        onTap: () {
          getx.Get.to(() => OrderDetails(orderModel: orderModel),
              transition: getx.Transition.rightToLeft);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 95.w,
              height: 95.h,
              child: StaggeredGrid.count(
                  crossAxisCount: (orderModel?.products.length ?? 0) < 4
                      ? orderModel?.products.length ?? 0
                      : 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: orderModel?.products
                          .map(
                            (e) => FancyShimmerImage(
                              imageUrl: e.image ?? "",
                              width: 95.w,
                              height: 95.h,
                              boxFit: BoxFit.cover,
                            ),
                          )
                          .toList() ??
                      []),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Text(
                    orderModel?.products.map((e) => e.name).join(', ') ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Delivered on 24 Feb 2021.".trim(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
