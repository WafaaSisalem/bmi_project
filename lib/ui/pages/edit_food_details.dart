
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/regestration%20pages/complete_info_page.dart';
import 'package:bmi_calculator_project/ui/pages/regestration%20pages/signin_page.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  'Create New Account',
                  style: headTextStyle1(),
                ),
                Text(
                  'If you do not already have an account',
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
                          return value.isEmpty || value.length < 3
                              ? 'User Name should be more than 2 characters!'
                              : null;
                        },
                        controller: userNameController,
                        // style: TextStyle(
                        //     fontSize: 14.sp, color: const Color(0xff404040)),
                        textInputAction: TextInputAction.next,
                        decoration: textFieldInputDecoration(hintText: 'Name'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
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
                      TextFormField(
                        validator: (value) {
                          return passwordController.text !=
                                  rePasswordController.text
                              ? 'Passwords not equals'
                              : null;
                        },
                        controller: rePasswordController,
                        obscureText: true,
                        // style: TextStyle(
                        //     fontSize: 14.sp, color: const Color(0xff404040)),
                        decoration: textFieldInputDecoration(
                            hintText: 'Re-Password', isPassword: true),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                buttonWidget('CREATE', () {
                  if (formKey.currentState.validate()) {
                    AppRouter.router
                        .pushWithReplacementFunction(CompleteInfoPage(
                      email: emailController.text,
                      password: passwordController.text,
                      userName: userNameController.text,
                    ));
                  }
                }),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You Hava an Account?'),
                    TextButton(
                        onPressed: () {
                          AppRouter.router
                              .pushWithReplacementFunction(LoginPage());
                        },
                        child: const Text('Login'))
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
