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
      create: (context) => HomeCubit()..getSubcategories(),
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: BlocSelector<HomeCubit, HomeState, int?>(
          selector: (state) => state.currentTab,
          builder: (context, currentTab) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                selectedItemColor: primaryColor,
                type: BottomNavigationBarType.shifting,
                onTap: (value) => context.read<HomeCubit>().changeTab(value),
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: SvgPicture.asset(
                      homeTabIcon,
                      color: currentTab == 0 ? primaryColor : borderColor,
                    ),
                    label: 'HOME',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return badges.Badge(
                          badgeAnimation: badges.BadgeAnimation.slide(
                              curve: Curves.elasticOut,
                              animationDuration: Duration(milliseconds: 1000)),
                          badgeContent: Text(
                            "${state.cartProducts?.length ?? 0}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          child: SvgPicture.asset(
                            cartTabIcon,
                            color: currentTab == 1 ? primaryColor : borderColor,
                          ),
                        );
                      },
                    ),
                    label: 'Shopping cart',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return badges.Badge(
                          badgeAnimation: badges.BadgeAnimation.slide(
                              curve: Curves.elasticOut,
                              animationDuration: Duration(milliseconds: 1000)),
                          badgeContent: Text(
                            "${state.favoriteProductsIds?.length ?? 0}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          child: SvgPicture.asset(
                            favoriteTabIcon,
                            color: currentTab == 2 ? primaryColor : borderColor,
                          ),
                        );
                      },
                    ),
                    label: 'Favourite',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: SvgPicture.asset(
                      profileTabIcon,
                      color: currentTab == 3 ? primaryColor : borderColor,
                    ),
                    label: 'My Account',
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
