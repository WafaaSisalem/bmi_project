import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/homepage.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRecordPage extends StatefulWidget {
  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
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
            buttonWidget('Save Data', () {
              AppRouter.router.pushWithReplacementFunction(HomePage());
            })
          ],
        ),
      ),
    );
  }
}
