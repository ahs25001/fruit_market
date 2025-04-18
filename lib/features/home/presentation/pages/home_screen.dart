import 'package:advanced_salomon_bottom_bar/advanced_salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/core/utils/app_images.dart';
import 'package:fruit_market/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSubcategories()..getCurrentUser(),
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: BlocSelector<HomeCubit, HomeState, int?>(
          selector: (state) => state.currentTab,
          builder: (context, currentTab) {
            return Scaffold(
              bottomNavigationBar: AdvancedSalomonBottomBar(
                selectedItemColor: primaryColor,
                itemShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                selectedColorOpacity: 1,
                duration: Duration(milliseconds: 300),
                
                onTap: (value) => context.read<HomeCubit>().changeTab(value),
                items: [
                  AdvancedSalomonBottomBarItem(
                    selectedColor: primaryColor,

                    unselectedColor: Colors.white,
                    icon: SvgPicture.asset(
                      homeTabIcon,
                      color: currentTab == 0 ? Colors.white : borderColor,
                    ),
                    title: Text(
                      'HOME',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  AdvancedSalomonBottomBarItem(
                    selectedColor: primaryColor,
                    unselectedColor: Colors.white,
                    icon: Row(
                      children: [
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return badges.Badge(
                              badgeAnimation: badges.BadgeAnimation.slide(
                                  curve: Curves.elasticOut,
                                  animationDuration:
                                      Duration(milliseconds: 1000)),
                              badgeContent: Text(
                                "${state.cartProducts?.length ?? 0}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.sp),
                              ),
                              child: SvgPicture.asset(
                                cartTabIcon,
                                color: currentTab == 1
                                    ? Colors.white
                                    : borderColor,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 5.w,
                        )
                      ],
                    ),
                    title: Text(
                      'Shopping cart',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ),
                  AdvancedSalomonBottomBarItem(
                    icon: Row(
                      children: [
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return badges.Badge(
                              badgeAnimation: badges.BadgeAnimation.slide(
                                  curve: Curves.elasticOut,
                                  animationDuration:
                                      Duration(milliseconds: 1000)),
                              badgeContent: Text(
                                "${state.favoriteProductsIds?.length ?? 0}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.sp),
                              ),
                              child: SvgPicture.asset(
                                favoriteTabIcon,
                                color: currentTab == 2
                                    ? Colors.white
                                    : borderColor,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 5.w,
                        )
                      ],
                    ),
                    title: Text(
                      'Favourite',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    selectedColor: primaryColor,
                    unselectedColor: Colors.white,
                  ),
                  AdvancedSalomonBottomBarItem(
                    icon: SvgPicture.asset(
                      profileTabIcon,
                      color: currentTab == 3 ? Colors.white : borderColor,
                    ),
                    title: Text(
                      'My Account',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    selectedColor: primaryColor,

                    unselectedColor: Colors.white,
                  ),
                ],
                currentIndex: currentTab ?? 0,
                backgroundColor: Colors.white,
              ),
              resizeToAvoidBottomInset: false,
              body: tabs[currentTab ?? 0],
            );
          },
        ),
      ),
    );
  }
}
