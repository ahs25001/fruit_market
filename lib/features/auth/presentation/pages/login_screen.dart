import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/core/utils/app_images.dart';
import 'package:fruit_market/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fruit_market/features/auth/presentation/pages/complet_data_screen.dart';
import 'package:fruit_market/features/home/presentation/pages/home_screen.dart';
import 'package:get/get.dart' as getx;

import '../widgets/login_item.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.loading) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    )),
                  );
                },
              );
            } else if ((state.status == AuthStatus.getUserSuccess &&
                (state.currentUser == null )||
                    state.status == AuthStatus.getUserError)) {
              // Navigator.pop(context);
              getx.Get.offAll(() => CompleteDataScreen(),
                  transition: getx.Transition.rightToLeftWithFade);
            } else if (state.status==AuthStatus.getUserSuccess&&state.currentUser!=null){
              getx.Get.offAll(()=>HomeScreen());
            }else if (state.status == AuthStatus.error) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                  content: Text(state.massage!),
                ),
              );
            }
          },
          builder: (context, state) => Column(
            children: [
              SizedBox(height: 120.h),
              Image.asset(
                marketImage,
                height: 266.h,
                width: 321.w,
              ),
              Text(
                "Fruit Market",
                style: TextStyle(
                    fontSize: 51.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 137.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LoginItem(
                    logoPath: googleLogo,
                    onTap: () {
                      AuthCubit.get(context).loginWithGoogle();
                    },
                  ),
                  LoginItem(
                    logoPath: faceBookLogo,
                    onTap: () {
                      AuthCubit.get(context).loginWithFacebook();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
