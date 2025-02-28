import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/add_data/presentation/wedgits/input_data_field.dart';
import 'package:get/get.dart' as getx;

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedBorder(
                color: Colors.black,
                dashPattern: [16.w, 16.w, 16.w, 16.w],
                child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 172.h,
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Colors.black54,
                      size: 40.sp,
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text("Selcet Category",
                  style: TextStyle(fontSize: 16.sp, color: primaryColor)),
              SizedBox(
                height: 20.h,
              ),
              DropdownMenu(
                  width: double.infinity,
                  menuStyle: MenuStyle(
                    surfaceTintColor: WidgetStatePropertyAll(primaryColor),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      side: BorderSide(color: primaryColor),
                    )),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
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
                    DropdownMenuEntry(label: "Vegetables", value: "vegetables"),
                    DropdownMenuEntry(label: "Dry Fruits", value: "dry Fruits"),
                  ]),
              SizedBox(
                height: 20.h,
              ),
              Text("Selcet Subcategory",
                  style: TextStyle(fontSize: 16.sp, color: primaryColor)),
              SizedBox(
                height: 20.h,
              ),
              DropdownMenu(
                  width: double.infinity,
                  menuStyle: MenuStyle(
                    surfaceTintColor: WidgetStatePropertyAll(primaryColor),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      side: BorderSide(color: primaryColor),
                    )),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
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
                    DropdownMenuEntry(label: "Vegetables", value: "vegetables"),
                    DropdownMenuEntry(label: "Dry Fruits", value: "dry Fruits"),
                  ]),
              SizedBox(height: 20.h),
              InputDataField(
                onSubmit: () {},
                hint: "Product Name",
                isDecription: false,
                controller: TextEditingController(),
                focusNode: FocusNode(),
                isNumber: false,
              ),
              SizedBox(height: 20.h),
              InputDataField(
                onSubmit: () {},
                hint: "Description",
                isDecription: true,
                controller: TextEditingController(),
                focusNode: FocusNode(),
                isNumber: false,
              ),
              SizedBox(height: 20.h),
              InputDataField(
                onSubmit: () {},
                hint: "Price per/kg",
                isDecription: false,
                controller: TextEditingController(),
                focusNode: FocusNode(),
                isNumber: true,
              ),
              SizedBox(height: 20.h),
              // ElevatedButton(onPressed: () {}, child: Tex)
              
            ],
          ),
        ),
      ),
    );
  }
}
