import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/core/firebase/firebase_auth_manager.dart';
import 'package:fruit_market/core/firebase/firebase_firestore_manager.dart';
import 'package:fruit_market/features/home/presentation/pages/cart_tab.dart';
import 'package:fruit_market/features/home/presentation/pages/favorite_list_tab.dart';
import 'package:fruit_market/features/home/presentation/pages/home_tab.dart';
import 'package:fruit_market/features/home/presentation/pages/profile_tab.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'app_images.dart';

String poppinsFont = "Poppins";
List<Widget>tabs=[HomeTab(),CartTab(),FavoriteListTab(),ProfileTab(),];
List<PageViewModel> onBoardingPages = [
  PageViewModel(
    bodyWidget: Text(
      "Explore  top organic fruits & grab them",
      style: TextStyle(color: Color(0XFF2F2E41), fontSize: 16.sp),
    ),
    titleWidget: Text(
      "E Shopping",
      style: TextStyle(
          color: Color(0XFF2F2E41),
          fontSize: 20.sp,
          fontWeight: FontWeight.w800),
    ),
    image: Center(child: SvgPicture.asset(firstOnboardingImage)),
  ),
  PageViewModel(
    bodyWidget: Text(
      "Get your order by speed delivery",
      style: TextStyle(color: Color(0XFF2F2E41), fontSize: 16.sp),
    ),
    titleWidget: Text(
      "Delivery on the way",
      style: TextStyle(
          color: Color(0XFF2F2E41),
          fontSize: 20.sp,
          fontWeight: FontWeight.w500),
    ),
    image: Center(
        child: SvgPicture.asset(secondOnboardingImage)),
  ),
  PageViewModel(
    bodyWidget: Text(
      "Order is arrived at your Place",
      style: TextStyle(color: Color(0XFF2F2E41), fontSize: 16.sp),
    ),
    titleWidget: Text(
      "Delivery Arrived",
      style: TextStyle(
          color: Color(0XFF2F2E41),
          fontSize: 20.sp,
          fontWeight: FontWeight.w500),
    ),
    image: Center(
        child: SvgPicture.asset(thirdOnboardingImage)),
  ),
];
FirebaseAuthManager firebaseAuthManager = FirebaseAuthManager.instance;
FirebaseFirestoreManager firebaseFirestoreManager = FirebaseFirestoreManager.instance;