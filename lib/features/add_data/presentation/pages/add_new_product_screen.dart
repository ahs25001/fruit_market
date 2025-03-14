import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/add_data/presentation/cubit/add_data_cubit.dart';
import 'package:fruit_market/features/add_data/presentation/wedgits/custom_drop_menu.dart';
import 'package:fruit_market/features/add_data/presentation/wedgits/input_data_field.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDataCubit()..getSubcategories(),
      child: BlocBuilder<AddDataCubit, AddDataState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return Form(
            key: AddDataCubit.get(context).formKey,
            child: Scaffold(
              // resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: InkWell(
                  onTap: () => getx.Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: primaryColor,
                title: const Text(
                  'Add New Product',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: BlocSelector<AddDataCubit, AddDataState, AddDataStatuse>(
                selector: (state) {
                  return state.statuse!;
                },
                builder: (context, state) {
                  return state == AddDataStatuse.loading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                BlocSelector<AddDataCubit, AddDataState,
                                    XFile?>(
                                  selector: (state) {
                                    return state.productImage;
                                  },
                                  builder: (context, state) {
                                    return (state == null)
                                        ? DottedBorder(
                                            color: Colors.black,
                                            dashPattern: [
                                              16.w,
                                              16.w,
                                              16.w,
                                              16.w
                                            ],
                                            child: Container(
                                                color: Colors.grey,
                                                width: double.infinity,
                                                height: 172.h,
                                                child: Icon(
                                                  Icons
                                                      .add_photo_alternate_outlined,
                                                  color: Colors.black54,
                                                  size: 40.sp,
                                                )),
                                          )
                                        : ClipRRect(
                                          borderRadius: BorderRadius.circular(16.r),
                                          child: Image.file(
                                              File(state.path),
                                              width: double.infinity,
                                              height: 172.h,
                                            ),
                                        );
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text("Selcet Category",
                                    style: TextStyle(
                                        fontSize: 16.sp, color: primaryColor)),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomDropMenu(
                                  controller: AddDataCubit.get(context)
                                      .categoryNameController,
                                  items: [
                                    DropdownMenuEntry(
                                        label: "Fruits", value: "fruits"),
                                    DropdownMenuEntry(
                                        label: "Vegetables",
                                        value: "vegetables"),
                                    DropdownMenuEntry(
                                        label: "Dry Fruits",
                                        value: "dry Fruits"),
                                  ],
                                  initialvalue: "fruits",
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text("Selcet Subcategory",
                                    style: TextStyle(
                                        fontSize: 16.sp, color: primaryColor)),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomDropMenu(
                                  controller: AddDataCubit.get(context)
                                      .subcategoryNameController,
                                  hint: "Select Subcategory",
                                  items: AddDataCubit.get(context)
                                          .state
                                          .subcategories
                                          ?.map((e) => DropdownMenuEntry(
                                              value: e.name,
                                              label: e.name ?? ""))
                                          .toList() ??
                                      [],
                                ),
                                SizedBox(height: 20.h),
                                InputDataField(
                                  onSubmit: () {
                                    FocusScope.of(context).requestFocus(
                                        AddDataCubit.get(context)
                                            .decorationFocusNode);
                                  },
                                  hint: "Product Name",
                                  isDecription: false,
                                  controller: AddDataCubit.get(context)
                                      .productNameController,
                                  focusNode: AddDataCubit.get(context)
                                      .productNameFocusNode,
                                  isNumber: false,
                                ),
                                SizedBox(height: 20.h),
                                InputDataField(
                                  onSubmit: () {
                                    FocusScope.of(context).requestFocus(
                                        AddDataCubit.get(context)
                                            .priceFocusNode);
                                  },
                                  hint: "Description",
                                  isDecription: true,
                                  controller: AddDataCubit.get(context)
                                      .descriptionController,
                                  focusNode: AddDataCubit.get(context)
                                      .decorationFocusNode,
                                  isNumber: false,
                                ),
                                SizedBox(height: 20.h),
                                InputDataField(
                                  onSubmit: () {
                                    Focus.of(context).requestFocus(
                                        AddDataCubit.get(context)
                                            .nutritionFocusNode);
                                  },
                                  hint: "Price per/kg",
                                  isDecription: false,
                                  controller:
                                      AddDataCubit.get(context).priceController,
                                  focusNode:
                                      AddDataCubit.get(context).priceFocusNode,
                                  isNumber: true,
                                ),
                                SizedBox(height: 20.h),
                                InputDataField(
                                  onSubmit: () {},
                                  isMultiLine: true,
                                  hint: "Nutrition",
                                  isDecription: true,
                                  controller: AddDataCubit.get(context)
                                      .nutritionController,
                                  focusNode: AddDataCubit.get(context)
                                      .nutritionFocusNode,
                                  isNumber: false,
                                ),
                                SizedBox(height: 20.h),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      backgroundColor: primaryColor,
                                    ),
                                    onPressed: () {
                                      if (AddDataCubit.get(context)
                                              .formKey
                                              .currentState!
                                              .validate() &&
                                          AddDataCubit.get(context)
                                              .subcategoryNameController
                                              .text
                                              .trim()
                                              .isNotEmpty) {
                                        print(AddDataCubit.get(context)
                                            .nutritionController
                                            .text
                                            .trim()
                                            .split("\n"));
                                      } else if (AddDataCubit.get(context)
                                          .subcategoryNameController
                                          .text
                                          .trim()
                                          .isEmpty) {
                                        getx.Get.showSnackbar(getx.GetSnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.red,
                                          message: "Select Subcategory",
                                        ));
                                      }
                                    },
                                    child: Text("Add Product",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)))
                              ],
                            ),
                          ),
                        );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
