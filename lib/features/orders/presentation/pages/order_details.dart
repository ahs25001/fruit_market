import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';
import 'package:fruit_market/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:fruit_market/features/orders/presentation/widgets/order_details_item.dart';
import 'package:get/get.dart' as getx;

class OrderDetails extends StatelessWidget {
  OrderModel ? orderModel;
  OrderDetails({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                getx.Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.sp,
                color: Colors.white,
              )),
          title: Text(
            'Order Details',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => OrderDetailsItem(
            orderId: orderModel?.id??"",
            product:orderModel?. products[index],
          ),
          itemCount: orderModel?.products.length??0,
          separatorBuilder: (context, index) => Divider(
            height: 5.h,
            thickness: 5.h,
            color: dividerColor,
          ),
        ),
      ),
    );
  }
}
