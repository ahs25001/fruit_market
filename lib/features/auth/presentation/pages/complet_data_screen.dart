import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fruit_market/features/auth/presentation/widgets/data_form_field.dart';
import 'package:fruit_market/features/home/presentation/pages/home_screen.dart';
import 'package:get/get.dart' as getx;

class CompleteDataScreen extends StatelessWidget {
  CompleteDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            Navigator.pop(context);
            getx.Get.showSnackbar(getx.GetSnackBar(
                duration: Duration(seconds: 2),
                isDismissible: true,
                backgroundColor: primaryColor,
                message: "Account has been logged successfully"));
            getx.Get.offAll(() => HomeScreen(),
                transition: getx.Transition.rightToLeftWithFade);
          } else if (state.status == AuthStatus.error) {
          } else if (state.status == AuthStatus.loading) {
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
          }
        },
        builder: (context, state) {
          return Form(
            key: AuthCubit.get(context).formKey,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DataFormField(
                        onSubmit: () {
                          FocusScope.of(context).requestFocus(
                              AuthCubit.get(context).phoneFocusNode);
                        },
                        focusNode: AuthCubit.get(context).nameFocusNode,
                        title: "Enter Your Name",
                        controller: AuthCubit.get(context).nameController,
                        isAddress: false,
                        isNumber: false,
                        validator: (value) {
                          if (value == null || value!.trim().isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                    DataFormField(
                        onSubmit: () {
                          FocusScope.of(context).requestFocus(
                              AuthCubit.get(context).addressFocusNode);
                        },
                        title: "Enter Your Phone Number",
                        focusNode: AuthCubit.get(context).phoneFocusNode,
                        controller: AuthCubit.get(context).phoneController,
                        isAddress: false,
                        isNumber: true,
                        validator: (value) {
                          if (value == null || value!.trim().isEmpty) {
                            return "Please Enter Your Phone Number";
                          }
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                    DataFormField(
                        onSubmit: () {
                          if (AuthCubit.get(context)
                              .formKey
                              .currentState!
                              .validate()) {
                            AuthCubit.get(context).completeInfo();
                          }
                        },
                        focusNode: AuthCubit.get(context).addressFocusNode,
                        title: "Add Address",
                        controller: AuthCubit.get(context).addressController,
                        isAddress: true,
                        isNumber: false,
                        validator: (value) {
                          if (value == null || value!.trim().isEmpty) {
                            return "Please Enter Your Address";
                          }
                        }),
                    SizedBox(
                      height: 50.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (AuthCubit.get(context)
                            .formKey
                            .currentState!
                            .validate()) {
                          AuthCubit.get(context).completeInfo();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),
                          padding: EdgeInsets.symmetric(vertical: 20.h)),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
