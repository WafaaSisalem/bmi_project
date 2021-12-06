import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/provider/firestore_provider.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/splash/splash_page.dart';
import 'package:bmi_calculator_project/ui/pages/add_record_page.dart';
import 'package:bmi_calculator_project/ui/pages/food_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpHelper.spHelper.initSharedPrefrence();
  runApp(ChangeNotifierProvider<FirestoreProvider>(
      create: (context) => FirestoreProvider(),
      child: MaterialApp(
        navigatorKey: AppRouter.router.routerKey,
        theme: ThemeData(
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: const Color(0xfffafafa)),
        home: ScreenUtilInit(
          builder: () {
            return FirebaseConfiguration();
          },
          designSize: const Size(390, 844),
        ),
      )));
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      builder: (context, snapShot) {
        if (snapShot.hasError) {
          return Scaffold(
            backgroundColor: Colors.red,
            body: Center(
              child: Text(snapShot.error.toString()),
            ),
          );
        }
        if (snapShot.connectionState == ConnectionState.done) {
          return AddRecordPage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
      future: Firebase.initializeApp(),
    );
  }
}
