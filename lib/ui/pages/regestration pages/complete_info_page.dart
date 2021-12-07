import 'dart:math';

import 'package:bmi_calculator_project/BMIMehtods/bmi_methods.dart';
import 'package:bmi_calculator_project/helpers/firebase_auth_helper.dart';
import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/models/record_model.dart';
import 'package:bmi_calculator_project/models/user_model.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/homepage.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteInfoPage extends StatefulWidget {
  String email;
  String password;
  String userName;
  CompleteInfoPage({this.email, this.password, this.userName});
  @override
  State<CompleteInfoPage> createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage> {
  int groupValue = 1;
  double lengthItemCount = 0;
  double weightItemCount = 0;
  static const String male = 'Male';
  static const String female = 'Female';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateOfBirthController = TextEditingController();
  save() async {
    if (formKey.currentState.validate()) {
      AuthHelper.authHelper
          .signUpWithEmailAndPassword(
              widget.email, widget.password, widget.userName)
          .then((value) {
        if (value != null) {
          ///////////BMI Equation
          double currentBMI = (weightItemCount /
                  pow(lengthItemCount / 100.0, 2)) *
              BMIMethods.getAgePercent(dateOfBirthController.text, groupValue);
          ////////////current status
          String currentStatusAsString = BMIMethods.getStatus(
              BMIMethods.getCategory(currentBMI), 0.0, 0.0);
          //////////user model
          UserModel userModel = UserModel(
              email: widget.email,
              userName: widget.userName,
              gender: groupValue == 1 ? male : female,
              dateOfBirth: dateOfBirthController.text,
              );
          //////////record model
          RecordModel recordModel = RecordModel(
              weight: weightItemCount,
              length: lengthItemCount,
              recordCategory: BMIMethods.getCategory(currentBMI),
              currentStatusAsString: currentStatusAsString,
              currentStatusAsDouble: currentBMI);
          ///////////add user to firestore 
          FirestoreHelper.firestoreHelper.addUserToFirestore(userModel.toMap());
          //////////add record to the user
          FirestoreHelper.firestoreHelper
              .addRecordToTheUser(recordModel, userModel.email);
          ///////set user info and state in shared preference
          SpHelper.spHelper.setUserInfo(userModel);
          SpHelper.spHelper.setUserLoggedInState(true);
          AppRouter.router.pushWithReplacementFunction(HomePage());
        }
      });
    }
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
                'Complete Your',
                style: headTextStyle1(),
              ),
              Text(
                'Information',
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
                          headText2Widget('Gender'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Weight'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Length'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Date of Birth'),
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: Radio(
                                    value: 1,
                                    groupValue: groupValue,
                                    onChanged: (value) {
                                      groupValue = value;
                                      setState(() {});
                                    }),
                              ),
                              const Text(
                                male,
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: Radio(
                                    value: 2,
                                    groupValue: groupValue,
                                    onChanged: (value) {
                                      groupValue = value;
                                      setState(() {});
                                    }),
                              ),
                              const Text(
                                female,
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
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
                            height: 55.h,
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                controller: dateOfBirthController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'you should enter your date of birth';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: detailsInputDecorationWidget(),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 80.h,
              ),
              buttonWidget('Save Data', () {
                save();
              })
            ],
          ),
        ),
      ),
    );
  }
}
