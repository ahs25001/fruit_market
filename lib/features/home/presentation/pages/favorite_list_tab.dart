import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_json.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:fruit_market/features/home/presentation/widgets/favorite_item.dart';
import 'package:lottie/lottie.dart';

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
                  "Favourites",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return  Expanded(
                          child: (state.favoriteProducts == null ||
                          state.favoriteProducts!.isEmpty)
                      ? Center(child: Lottie.asset(emptyList))
                      :ListView(
                          children: [
                            ...state.favoriteProducts!.map((e) {
                              int currentIndex =
                                  state.favoriteProducts!.indexOf(e);
                              if (currentIndex == 0 ||
                                  e.categoryName !=
                                      state.favoriteProducts![currentIndex - 1]
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
                                      child: FavoriteItem(
                                        removeProductFromFavoriteList: () {
                                          context
                                              .read<HomeCubit>()
                                              .removeProductFromFavorite(
                                                  e.id ?? "");
                                        },
                                        isInCart:
                                            state.cartIds?.contains(e.id) ??
                                                false,
                                        addToCart: () {
                                          context
                                              .read<HomeCubit>()
                                              .addProductToCart(CartModel(
                                                  uid: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  id: e.id,
                                                  name: e.name,
                                                  categoryName: e.categoryName,
                                                  price: e.price,
                                                  image: e.image,
                                                  quntitiy: e.quntitiy ?? 1));
                                        },
                                        removeFromCart: () {
                                          context
                                              .read<HomeCubit>()
                                              .removeProductFromCart(e.id!);
                                        },
                                        onDec: () => context
                                            .read<HomeCubit>()
                                            .decQuantityInFavorite(e),
                                        onInc: () => context
                                            .read<HomeCubit>()
                                            .incQuantityInFavorite(e),
                                        productModel: e,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return FadeInRight(
                                duration: Duration(
                                    milliseconds: (currentIndex + 1) * 100),
                                child: FavoriteItem(
                                  removeProductFromFavoriteList: () {
                                    context
                                        .read<HomeCubit>()
                                        .removeProductFromFavorite(e.id ?? "");
                                  },
                                  isInCart:
                                      state.cartIds?.contains(e.id) ?? false,
                                  addToCart: () {
                                    context.read<HomeCubit>().addProductToCart(
                                        CartModel(
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            id: e.id,
                                            name: e.name,
                                            categoryName: e.categoryName,
                                            price: e.price,
                                            image: e.image,
                                            quntitiy: e.quntitiy ?? 1));
                                  },
                                  removeFromCart: () {
                                    context
                                        .read<HomeCubit>()
                                        .removeProductFromCart(e.id!);
                                  },
                                  onDec: () => context
                                      .read<HomeCubit>()
                                      .decQuantityInFavorite(e),
                                  onInc: () => context
                                      .read<HomeCubit>()
                                      .incQuantityInFavorite(e),
                                  productModel: e,
                                ),
                              );
                            })
                          ],
                        ));
                  //  Expanded(
                  //     child: ListView.separated(
                  //         itemBuilder: (context, index) => FadeInRight(
                  //               duration: Duration(
                  //                   milliseconds: (index + 1) * 100),
                  //               child: FavoriteItem(
                  //                   onDec: () => context
                  //                       .read<HomeCubit>()
                  //                       .decQuntity(state
                  //                           .favoriteProducts![index]),
                  //                   onInc: () => context
                  //                       .read<HomeCubit>()
                  //                       .incQuntity(state
                  //                           .favoriteProducts![index]),
                  //                   productModel:
                  //                       state.favoriteProducts?[index]),
                  //             ),
                  //         itemCount: state.favoriteProducts?.length ?? 0,
                  //         separatorBuilder: (context, index) {
                  //           if (index == 0) {
                  //             return Container(
                  //               width: double.infinity,
                  //               color: Colors.grey.shade200,
                  //               child: Text(
                  //                   "${state.favoriteProducts?[index].categoryName}"),
                  //             );
                  //           } else {
                  //             return Divider(
                  //               color: Colors.grey.shade400,
                  //             );
                  //           }
                  //         }));
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
