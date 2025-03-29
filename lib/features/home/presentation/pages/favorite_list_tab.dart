import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:fruit_market/features/home/presentation/widgets/favorite_item.dart';

class FavoriteListTab extends StatelessWidget {
  const FavoriteListTab({super.key});

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
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.w,
                ),
                Text(
                  "Favourites",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Expanded(
                        child: ListView.separated(
                      itemBuilder: (context, index) => FavoriteItem(
                          productModel:
                              state.fruitSubCategories?[2]?.products?[index]),
                      itemCount:
                          state.fruitSubCategories?[2]?.products?.length ?? 0,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade400,
                      ),
                    ));
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
