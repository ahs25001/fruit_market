import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/models/category_model.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/add_data/presentation/pages/add_data_screen.dart';
import 'package:fruit_market/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:fruit_market/features/home/presentation/pages/subcategory_tab.dart';
import 'package:fruit_market/features/home/presentation/widgets/catigory_item.dart';
import 'package:fruit_market/features/home/presentation/widgets/loading_data.dart';
import 'package:fruit_market/features/home/presentation/widgets/search_field.dart';
import 'package:get/get.dart' as getx;

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: primaryColor,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
            ),
          )
        ],
      ),
      SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.status == HomeStatus.error) {
              getx.Get.showSnackbar(getx.GetSnackBar(
                snackPosition: getx.SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                message: state.massage,
              ));
            }
          },
          buildWhen: (previous, current) =>
              current.status == HomeStatus.getSubcategoriesLoading ||
              current.status == HomeStatus.getSubcategoriesSuccess,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 20.w),
                    SlideInLeft(
                      // duration: Duration(milliseconds: 300),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "F",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "ruit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        TextSpan(
                          text: " M",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "arket",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ])),
                    ),
                    Spacer(),
                    SlideInRight(
                      // duration: Duration(microseconds: 300),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    SlideInRight(
                      // duration: Duration(microseconds: 300),
                      child: InkWell(
                        onTap: () {
                          getx.Get.to(() => AddDataScreen(),
                              transition: getx.Transition.rightToLeftWithFade);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: SlideInDown(
                    child: SearchField(),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                TabBar(
                  splashFactory: NoSplash.splashFactory,
                  dividerColor: Colors.transparent,
                  onTap: (index) {
                    HomeCubit.get(context).changePage(index);
                  },
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    SlideInLeft(
                      duration: Duration(milliseconds: 400),
                      child: CategoryItem(
                        categoryModel: CategoryModel(name: "Vegetables"),
                        isSlected: state.currentPage == 0,
                      ),
                    ),
                    CategoryItem(
                      categoryModel: CategoryModel(name: "Fruits"),
                      isSlected: state.currentPage == 1,
                    ),
                    SlideInRight(
                      duration: Duration(milliseconds: 400),
                      child: CategoryItem(
                        categoryModel: CategoryModel(name: "Dry Fruits"),
                        isSlected: state.currentPage == 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                (state.status == HomeStatus.getSubcategoriesLoading ||
                        state.status == HomeStatus.getUserLoading)
                    ? LoadingData()
                    : Expanded(
                        child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                            SubcategoryTab(state.vegetablesSubCategories),
                            SubcategoryTab(state.fruitSubCategories),
                            SubcategoryTab(state.dryFruitsSubCategories),
                          ])),
              ],
            );
          },
        ),
      ),
    ]);
  }
}
