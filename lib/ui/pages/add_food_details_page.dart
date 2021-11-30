import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/homepage.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFoodDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Food Details',
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
                          headText2Widget('Name'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Category'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Calory'),
                          SizedBox(
                            height: 40.h,
                          ),
                          headText2Widget('Photo'),
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35.h,
                            child: TextField(
                              decoration: detailsInputDecorationWidget()
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 35.h,
                            child: TextField(
                              decoration: detailsInputDecorationWidget()
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 35.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: detailsInputDecorationWidget()
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    ' cal/g',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 65.h,
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Center(child: Icon(Icons.camera_enhance,size: 60,color: Colors.white,),),
                height: 250.h,
                color: Colors.blue,
                width: double.infinity,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: buttonWidget('Upload Photo', () {}),
                    flex: 2,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: buttonWidget('Save', () {}),
                    flex: 1,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
