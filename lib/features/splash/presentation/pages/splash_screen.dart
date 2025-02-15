import 'package:flutter/material.dart';
import 'package:fruit_market/features/splash/presentation/widgets/splash_body.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBody(),
    );
  }
}
