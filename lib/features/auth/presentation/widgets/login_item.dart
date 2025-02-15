import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_market/core/utils/app_colors.dart';

// ignore: must_be_immutable
class LoginItem extends StatelessWidget {
  String logoPath;
  VoidCallback onTap;

  LoginItem({super.key, required this.logoPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            SvgPicture.asset(logoPath),
            SizedBox(
              width: 15.w,
            ),
            Text(
              "Login with",
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            )
          ],
        ),
      ),
    );
  }
}
