import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/auth/presentation/pages/login_screen.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
            showDoneButton: true,
            showNextButton: true,
            showSkipButton: true,
            dotsDecorator: DotsDecorator(
              activeColor: primaryColor,
              color: Colors.white,
              shape: CircleBorder(side: BorderSide(color: primaryColor)),
            ),
            done: Text(
              "Done",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            doneStyle: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h)),
            next: Text(
              "Next",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            nextStyle: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h)),
            skip: Text(
              "Skip",
              style: TextStyle(color: primaryColor),
            ),
            onDone: () {
              Get.offAll(()=>LoginScreen(),transition: Transition.rightToLeftWithFade);
            },
            scrollPhysics: const NeverScrollableScrollPhysics(),
            pages:onBoardingPages

        ),
      ),
    );
  }
}
