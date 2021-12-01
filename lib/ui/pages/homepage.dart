import 'package:bmi_calculator_project/BMIMehtods/bmi_methods.dart';
import 'package:bmi_calculator_project/helpers/firebase_auth_helper.dart';
import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/add_food_details_page.dart';
import 'package:bmi_calculator_project/ui/pages/add_record_page.dart';
import 'package:bmi_calculator_project/ui/pages/food_list_page.dart';
import 'package:bmi_calculator_project/ui/pages/regestration%20pages/signin_page.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentStatus = '';
  @override
  void initState()  {
    super.initState();
    initCurrentStatus();
  }
  initCurrentStatus()async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirestoreHelper
        .firestoreHelper
        .getUserRecordsById(SpHelper.spHelper.getUserInfo().email);
        
       currentStatus = querySnapshot.docs[0].data()[FirestoreHelper.currentStatusKey];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hi, ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      SpHelper.spHelper.getUserInfo().userName,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                headText2Widget('Current Status'),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Center(
                      child: Text(
                    currentStatus,
                    style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                  )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                headText2Widget('Old Status'),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        oldStatusItemWidget(),
                        oldStatusItemWidget(),
                        oldStatusItemWidget(),
                        oldStatusItemWidget(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                        child: buttonWidget('Add Food', () {
                      AppRouter.router.pushFunction(AddFoodDetailsPage());
                    })),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: buttonWidget(
                      'Add Record',
                      () {
                        AppRouter.router.pushFunction(AddRecord());
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                buttonWidget('View Food', () {
                  AppRouter.router.pushFunction(FoodListPage());
                }, width: double.infinity),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      AuthHelper.authHelper.signOut();
                      AppRouter.router.pushWithReplacementFunction(LoginPage());
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
