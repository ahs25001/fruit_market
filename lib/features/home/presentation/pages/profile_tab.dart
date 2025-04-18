import 'package:animate_do/animate_do.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/core/utils/app_images.dart';
import 'package:fruit_market/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:fruit_market/features/home/presentation/widgets/feature_divider.dart';
import 'package:fruit_market/features/home/presentation/widgets/profile_feature_item.dart';
import 'package:shimmer/shimmer.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: primaryColor,
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Positioned(
          left: MediaQuery.sizeOf(context).width / 2 - 85.r,
          top: 67.h,
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                current.status == HomeStatus.getUserSuccess ||
                current.status == HomeStatus.getUserLoading,
            builder: (context, state) {
              return Column(
                children: [
                  (currentUser?.image == null || currentUser?.image == "")
                      ? CircleAvatar(
                          radius: 50.r,
                          child: Icon(
                            Icons.person,
                            size: 50.sp,
                            color: Colors.black,
                          ),
                        )
                      : FadeInDown(
                          duration: Duration(milliseconds: 500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: FancyShimmerImage(
                              boxFit: BoxFit.cover,
                              errorWidget: Image.asset(errorImage),
                              imageUrl: currentUser?.image ?? "",
                              width: 100.w,
                              height: 100.h,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  state.status == HomeStatus.getUserLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            width: 150.w,
                            height: 15.h,
                          ),
                        )
                      : FadeInLeft(
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            (currentUser?.name ?? "").trim(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 5.h,
                  ),
                  state.status == HomeStatus.getUserLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            width: 170.w,
                            height: 15.h,
                          ),
                        )
                      : FadeInRight(
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            currentUser?.email ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                ],
              );
            },
          ),
        ),
        Positioned(
          top: 67.h,
          right: 20.w,
          child: SlideInRight(
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            child: SvgPicture.asset(editeIcon),
          ),
        ),
        Column(
          children: [
            Spacer(
              flex: 3,
            ),
            Expanded(
              flex: 5,
              child: ListView(
                // shrinkWrap: true,
                children: [
                  FadeInRight(
                    duration: Duration(milliseconds: 100),
                    child: ProfileFeatureItem(
                      onTab: () {},
                      imagePath: ordarsIcon,
                      title: "My Orders",
                    ),
                  ),
                  FeatureDivider(),
                  FadeInRight(
                    duration: Duration(milliseconds: 200),
                    child: ProfileFeatureItem(
                      onTab: () {
                        context.read<HomeCubit>().changeTab(2);
                      },
                      imagePath: favoriteIcon,
                      title: "Favourites",
                    ),
                  ),
                  FeatureDivider(),
                  FadeInRight(
                    duration: Duration(milliseconds: 300),
                    child: ProfileFeatureItem(
                      onTab: () {},
                      imagePath: settingsIcon,
                      title: "Settings",
                    ),
                  ),
                  FeatureDivider(),
                  FadeInRight(
                    duration: Duration(milliseconds: 400),
                    child: ProfileFeatureItem(
                      onTab: () {
                        context.read<HomeCubit>().changeTab(1);
                      },
                      imagePath: cartIcon,
                      title: "My Cart",
                    ),
                  ),
                  FeatureDivider(),
                  FadeInRight(
                    duration: Duration(milliseconds: 500),
                    child: ProfileFeatureItem(
                      onTab: () {},
                      imagePath: rateUsIcon,
                      title: "Rate us",
                    ),
                  ),
                  FeatureDivider(),
                  FadeInRight(
                    duration: Duration(milliseconds: 600),
                    child: ProfileFeatureItem(
                      onTab: () {},
                      imagePath: shareIcon,
                      title: "Refer a Friend",
                    ),
                  ),
                  FeatureDivider(),
                  FadeInRight(
                    duration: Duration(milliseconds: 700),
                    child: ProfileFeatureItem(
                      onTab: () {},
                      imagePath: helpIcon,
                      title: "Help",
                    ),
                  ),
                  FeatureDivider(),
                  FadeInRight(
                    duration: Duration(milliseconds: 800),
                    child: ProfileFeatureItem(
                      onTab: () {},
                      imagePath: logOutIcon,
                      title: "Log Out",
                    ),
                  ),
                  FeatureDivider(),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
