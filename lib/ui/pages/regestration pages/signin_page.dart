import 'package:bmi_calculator_project/helpers/firebase_auth_helper.dart';
import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/models/user_model.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/homepage.dart';
import 'package:bmi_calculator_project/ui/pages/regestration%20pages/signup_page.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  QuerySnapshot querySnapshot;
  save() async {
    if (formKey.currentState.validate()) {
      AuthHelper.authHelper
          .signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      )
          .then((value) async {
        if (value != null) {
          UserModel userModel = value;
          QuerySnapshot signInSnapShot = await FirestoreHelper.firestoreHelper
              .getUserByEmail(userModel.email);
          SpHelper.spHelper.setUserInfo(UserModel(
              email: userModel.email,
              userName: signInSnapShot.docs[0][FirestoreHelper.userNameKey],
              gender: signInSnapShot.docs[0][FirestoreHelper.genderKey],
              dateOfBirth: signInSnapShot.docs[0][FirestoreHelper.dateOfBirthKey]
              ));
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: headTextStyle1(),
                ),
                Text(
                  'If you already have an account log in',
                  style: subTextStyle1(),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return regExp().hasMatch(value)
                              ? null
                              : 'Please enter a valid email!';
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        // style: TextStyle(
                        //     fontSize: 14.sp, color: const Color(0xff404040)),
                        textInputAction: TextInputAction.next,
                        decoration:
                            textFieldInputDecoration(hintText: 'E-Mail'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty || value.length < 7
                              ? 'Password should be more than 6 characters'
                              : null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        // style: TextStyle(
                        //     fontSize: 14.sp, color: const Color(0xff404040)),
                        decoration: textFieldInputDecoration(
                            hintText: 'Password', isPassword: true),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                buttonWidget('LOG IN', () {
                  save();
                }),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You Don\'t Hava an Account?'),
                    TextButton(
                        onPressed: () {
                          AppRouter.router
                              .pushWithReplacementFunction(SignUpPage());
                        },
                        child: const Text('Sign Up'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
