import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spinner_input/spinner_input.dart';

showCustomDialog(String message, [Function function]) {
  showDialog(
      context: AppRouter.router.routerKey.currentContext,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  if (function == null) {
                    AppRouter.router.back();
                  } else {
                    function();
                    AppRouter.router.back();
                  }
                },
                child: const Text('OK'))
          ],
        );
      });
}

InputDecoration textFieldInputDecoration({hintText, isPassword = false}) {
  return InputDecoration(
    suffixIcon: isPassword ? const Icon(Icons.visibility_off_outlined) : null,
    hintText: hintText,
    enabledBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
  );
}

buttonWidget(text, function, {width = 300.0}) {
  return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.blue,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ));
}

appBarWidget() {
  return AppBar(
    centerTitle: true,
    title: const Text(
      'BMI Analyzer',
    ),
  );
}

headTextStyle1() {
  return TextStyle(
      fontSize: 35.sp, fontWeight: FontWeight.bold, color: Colors.blue);
}

headText2Widget(text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.blue, fontSize: 20.sp, fontWeight: FontWeight.w600),
  );
}

subTextStyle1() {
  return TextStyle(fontSize: 16.sp, color: Colors.grey);
}

regExp() {
  return RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
      caseSensitive: false);
}

counterIncDec(itemCount, function) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
    ),
    child: SpinnerInput(
      minValue: 0,
      maxValue: 300,
      step: 1,
      plusButton: SpinnerButtonStyle(
        child: Container(
          child: const Icon(
            Icons.add,
            color: Colors.blue,
            size: 30,
          ),
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide.none,
                  vertical: BorderSide(color: Colors.blue))),
        ),
        color: const Color(0xfffafafa),
        elevation: 0,
        borderRadius: BorderRadius.circular(0),
      ),
      minusButton: SpinnerButtonStyle(
        child: Container(
          child: const Icon(Icons.remove, color: Colors.blue, size: 30),
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide.none,
                  vertical: BorderSide(color: Colors.blue))),
        ),
        color: const Color(0xfffafafa),
        elevation: 0,
        borderRadius: BorderRadius.circular(0),
      ),
      middleNumberWidth: 110.w,
      popupButton: SpinnerButtonStyle(
        color: Colors.white,
        textColor: Colors.blue,
        borderRadius: BorderRadius.circular(0),
      ),
      spinnerValue: itemCount,
      onChange: function,
    ),
  );
}

oldStatusItemWidget({String date ='',String weight='',String statusAsString='',String length=''}) {
  return Container(
    height: 100.h,
    margin: EdgeInsets.symmetric(vertical: 10.h),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
    child: Table(
      border: TableBorder.all(
          color: Colors.blue, borderRadius: BorderRadius.circular(5.r)),
      children: [
        TableRow(children: [
          SizedBox(
            height: 50.h,
            child:  Center(child: Center(child: Text(date))),
          ),
          SizedBox(height: 50.h, child:  Center(child: Text(weight+' Kg')))
        ]),
        TableRow(children: [
          SizedBox(
            height: 50.h,
            child:  Center(child: Text(statusAsString)),
          ),
          SizedBox(height: 50.h, child:  Center(child: Text(length+' Cm')))
        ])
      ],
    ),
  );
}

foodListItem() {
  return SizedBox(
    height: 80.h,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child:const Center(
              child: Text('Picture'),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: Colors.transparent,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                        child: Text(
                      'Salamon',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
                    Expanded(
                        child: Text('Fish',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey))),
                    Expanded(
                        child: Text('22 cal/g',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey)))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10.w, top: 10.h),
                      width: 80.w,
                      height: 40.h,
                      child: buttonWidget('Edit', () {}),
                    ),
                    Container(
                      height: 20.h,
                      width: 30.w,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      )),
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: Colors.transparent,
            ),
          ),
        )
      ],
    ),
  );
}

detailsInputDecorationWidget() {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: Colors.blue)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: Colors.blue)));
}
