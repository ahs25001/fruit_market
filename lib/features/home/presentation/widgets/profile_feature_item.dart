import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// ***********  ✨ Windsurf Command ⭐  ************
class ProfileFeatureItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTab;

  const ProfileFeatureItem({
    Key? key,
    required this.imagePath,
    required this.onTab,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          children: [
            SvgPicture.asset(imagePath),
            SizedBox(
              width: 20.w,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*******  bb1990f6-cfec-47a3-b74b-1998027bee86  *******/