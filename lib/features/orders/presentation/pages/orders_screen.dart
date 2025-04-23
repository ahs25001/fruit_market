import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:fruit_market/features/orders/presentation/widgets/order_item.dart';
import 'package:get/get.dart' as getx;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..getOrders(),
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
            'My Orders',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return (state.status == OrdersStatus.loading)
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => OrderItem(
                      orderModel: state.orders?[index],
                    ),
                    itemCount: state.orders?.length ?? 0,
                    separatorBuilder: (context, index) => Divider(
                      color: borderColor,
                      height: 2.h,
                      thickness: 2.h,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
