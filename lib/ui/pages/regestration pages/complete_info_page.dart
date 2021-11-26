import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/homepage.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteInfoPage extends StatefulWidget {
  @override
  State<CompleteInfoPage> createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage> {
  int groupValue = 1;
  double lengthItemCount = 0;
  double weightItemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
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
                              'Male',
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
                              'Female',
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
                          height: 35.h,
                          child: TextField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide:
                                        const BorderSide(color: Colors.blue)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide:
                                        const BorderSide(color: Colors.blue))),
                          ),
                        )
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 80.h,
            ),
            buttonWidget('Save Data', () {AppRouter.router.pushWithReplacementFunction(HomePage());})
          ],
        ),
      ),
    );
  }
}
