import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/constants/constants.dart';
import 'package:learn_flutter/services/auth_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 2000,
        splash: Image.asset(
          'assets/images/icon.png',
        ),
        nextScreen: const AuthPage(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.theme,
        backgroundColor: white);
  }
}
