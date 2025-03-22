import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomDropMenu extends StatelessWidget {
TextEditingController controller;
String?hint;
String ? initialvalue;
Function onSelected;
List<DropdownMenuEntry<dynamic>> items;
  CustomDropMenu({super.key, required this.controller,required this.onSelected, required this.items,this.hint, this.initialvalue});
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      
        controller: controller,
        width: double.infinity,
        menuStyle: MenuStyle(
          surfaceTintColor: WidgetStatePropertyAll(primaryColor),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
            side: BorderSide(color: primaryColor),
          )),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        hintText: hint,
        initialSelection: initialvalue,
        onSelected: (value) => onSelected(value),
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
        dropdownMenuEntries: items);
  }
}
