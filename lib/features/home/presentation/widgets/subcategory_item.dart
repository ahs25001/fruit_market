import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:fruit_market/features/home/presentation/widgets/fruit_item.dart';

// ignore: must_be_immutable
class SubcategoryItem extends StatelessWidget {
  SubCategoryModel? subCategoryModel;
  SubcategoryItem(this.subCategoryModel);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            subCategoryModel?.name ?? "",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20.w,
          ),
          (subCategoryModel?.discounts == null)
              ? SizedBox()
              : Text(
                  "(${subCategoryModel!.discounts}% Off)",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w600),
                ),
        ],
      ),
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        height: 240.h,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 20.w,
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return FruitItem(
                subcategoryId: subCategoryModel?.id,
                isInCart: state.cartIds!
                    .contains(subCategoryModel?.products?[index].id),
                addProductToFavorite: () {
                  context.read<HomeCubit>().addProductToFavorite(
                      subCategoryModel?.products?[index],
                      subCategoryModel?.id ?? "");
                },
                removeProductFromFavorite: () {
                  context.read<HomeCubit>().removeProductFromFavorite(
                      subCategoryModel?.products?[index].id ?? "");
                },
                productModel: subCategoryModel?.products?[index],
                isFavorite: state.favoriteProductsIds!
                    .contains(subCategoryModel?.products?[index].id),
              );
            },
          ),
          itemCount: subCategoryModel?.products?.length ?? 0,
        ),
      )
    ]);
  }
}
