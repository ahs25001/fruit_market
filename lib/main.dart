import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/core/utils/app_colors.dart';
import 'package:fruit_market/features/splash/presentation/pages/splash_screen.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: "https://ursnicgyajhbfhcuzoqo.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyc25pY2d5YWpoYmZoY3V6b3FvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI1NTE2NjEsImV4cCI6MjA1ODEyNzY2MX0.mpVB-OyH-myEUtBaStwS_0jbP3VR8y33AvcfALuVtC8");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        theme: ThemeData(
            fontFamily: poppinsFont,
            scaffoldBackgroundColor: Colors.white,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: primaryColor,
              selectionColor: primaryColor.withOpacity(.5),
              selectionHandleColor: primaryColor,
            )),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // onGenerateRoute: (settings) => Routs.onGenerateRoute(settings),
      ),
    );
  }
}
