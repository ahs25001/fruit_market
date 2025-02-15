import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/add_data/presentation/cubit/add_data_cubit.dart';
import 'package:get/get.dart' as getx;

// ignore: must_be_immutable
class AddSubCategoryDialog extends StatelessWidget {
  VoidCallback onSave;

  AddSubCategoryDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FadeInUp(
        duration: Duration(milliseconds: 500),
        child: AlertDialog(
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                backgroundColor: primaryColor,
              ),
              onPressed: () => onSave(),
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(15.r)),
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                getx.Get.back();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            )
          ],
          shadowColor: Colors.transparent,
          // backgroundColor: Colors.transparent,
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: AddDataCubit.get(context).subcategoryNameController,
                    cursorOpacityAnimates: true,
                    decoration: InputDecoration(
                        labelText: "Subcategory name",
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: BorderSide(color: primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: BorderSide(color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: BorderSide(color: primaryColor)))),
                SizedBox(
                  height: 20.h,
                ),
                DropdownMenu(
                    width: MediaQuery.of(context).size.width * .55,
                    menuStyle: MenuStyle(
                      surfaceTintColor: WidgetStatePropertyAll(primaryColor),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        side: BorderSide(color: primaryColor),
                      )),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    controller:
                        AddDataCubit.get(context).categoryNameController,
                    initialSelection: "fruits",
                    inputDecorationTheme: InputDecorationTheme(
                        hoverColor: primaryColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(color: primaryColor),
                        )),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(label: "Fruits", value: "fruits"),
                      DropdownMenuEntry(
                          label: "Vegetables", value: "vegetables"),
                      DropdownMenuEntry(
                          label: "Dry Fruits", value: "dry Fruits"),
                    ])
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
