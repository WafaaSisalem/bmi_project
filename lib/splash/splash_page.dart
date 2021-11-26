import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/homepage.dart';
import 'package:bmi_calculator_project/ui/pages/regestration%20pages/signup_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  navigateToHomeScreen() async {
    await Future.delayed(
        Duration(
          seconds: 2,
        ),
        () {});
    AppRouter.router.pushWithReplacementFunction(
        SpHelper.spHelper.getUserLoggedInState() == true
            ? HomePage()
            : SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bmi_logo.jpg',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
