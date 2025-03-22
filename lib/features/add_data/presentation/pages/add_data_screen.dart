import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/add_data/presentation/cubit/add_data_cubit.dart';
import 'package:fruit_market/features/add_data/presentation/pages/add_new_product_screen.dart';
import 'package:fruit_market/features/add_data/presentation/wedgits/add_sub_category_dialog.dart';
import 'package:get/get.dart' as getx;

class AddDataScreen extends StatelessWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddDataCubit addDataCubit = AddDataCubit();
    return BlocProvider(
      create: (context) => addDataCubit,
      child: BlocConsumer<AddDataCubit, AddDataState>(
        listener: (context, state) {
          if (state.statuse == AddDataStatuse.addSubcategoryLoading) {
            getx.Get.back();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.transparent,
                content: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              ),
            );
          } else if (state.statuse == AddDataStatuse.addSubcategorySuccess) {
            getx.Get.back();
            getx.Get.showSnackbar(getx.GetSnackBar(
              backgroundColor: primaryColor,
              message: "Data added succefully",
              duration: Duration(seconds: 2),
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  ListTile(
                    tileColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.r)),
                    title: Text(
                      "Add new subcategory",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        // barrierColor: Colors.transparent,
                        builder: (context) => BlocProvider.value(
                          value: addDataCubit,
                          child: BlocBuilder<AddDataCubit, AddDataState>(
                            buildWhen: (previous, current) => false,
                            builder: (context, state) {
                              return AddSubCategoryDialog(
                                onSave: () {
                                  AddDataCubit.get(context).saveSubcategory();
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListTile(
                    tileColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.r)),
                    title: Text(
                      "Add new product",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      getx.Get.to(()=>AddNewProductScreen(),transition: getx.Transition.rightToLeftWithFade);
                    },
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
