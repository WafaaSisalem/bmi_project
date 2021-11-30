import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
        child: Column(
          children: [
            Text(
              'Food List',
              style: headTextStyle1(),
            ),
            SizedBox(
              height: 50.h,
            ),
            foodListItem(),
          ],
        ),
      ),
    );
  }
}
