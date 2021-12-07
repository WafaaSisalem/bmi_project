import 'dart:math';
import 'package:bmi_calculator_project/BMIMehtods/bmi_methods.dart';
import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/models/record_model.dart';
import 'package:bmi_calculator_project/provider/firestore_provider.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/homepage.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddRecordPage extends StatefulWidget {
  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  double lengthItemCount = 0;
  double weightItemCount = 0;
  save() async {
    ///////////BMI Equation
    double currentBMI = (weightItemCount / pow(lengthItemCount / 100.0, 2)) *
        BMIMethods.getAgePercent(SpHelper.spHelper.getUserInfo().dateOfBirth,
            SpHelper.spHelper.getUserInfo().gender == 'Male' ? 1 : 2);
    ////////////current status
    String currentStatusAsString = BMIMethods.getStatus(
        Provider.of<FirestoreProvider>(context, listen: false).currentStatusAsString,
        currentBMI,
        Provider.of<FirestoreProvider>(context, listen: false)
            .currentStatusAsDouble);

    //////////record model
    RecordModel recordModel = RecordModel(
        weight: weightItemCount,
        length: lengthItemCount,
        recordCategory:BMIMethods.getCategory(currentBMI),
        currentStatusAsString: currentStatusAsString,
        currentStatusAsDouble: currentBMI);
    //////////add record to the user
    FirestoreHelper.firestoreHelper
        .addRecordToTheUser(recordModel, SpHelper.spHelper.getUserInfo().email);
    ///////set user info and state in shared preference

    AppRouter.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Text(
                'New Record',
                style: headTextStyle1(),
              ),
              SizedBox(height: 60.h),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headText2Widget('Weight'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Length'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Date'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Time'),
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              counterIncDec(weightItemCount, (newValue) {
                                setState(() {
                                  weightItemCount = newValue;
                                });
                              }),
                              SizedBox(
                                width: 5.w,
                              ),
                              const Text(
                                'kg',
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              counterIncDec(lengthItemCount, (newValue) {
                                setState(() {
                                  lengthItemCount = newValue;
                                });
                              }),
                              SizedBox(
                                width: 5.w,
                              ),
                              const Text(
                                'cm',
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 35.h,
                            child: TextField(
                              decoration: detailsInputDecorationWidget(),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 35.h,
                            child: TextField(
                              decoration: detailsInputDecorationWidget(),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 80.h,
              ),
              buttonWidget('Save Data', () {
                save();
                AppRouter.router.pushWithReplacementFunction(HomePage());
              })
            ],
          ),
        ),
      ),
    );
  }
}
