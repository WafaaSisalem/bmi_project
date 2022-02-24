import 'package:bmi_calculator_project/helpers/firestorage_helper.dart';
import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/models/food_details_model.dart';
import 'package:bmi_calculator_project/provider/firestore_provider.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddFoodDetailsPage extends StatefulWidget {
  @override
  State<AddFoodDetailsPage> createState() => _AddFoodDetailsPageState();
}

class _AddFoodDetailsPageState extends State<AddFoodDetailsPage> {
  List categories = getCategoriesList();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController caloryController = TextEditingController();
  String dropDownValue = 'Fruits';
  String imageUrl;
  save() async {
    FoodDetailsModel foodDetailsModel = FoodDetailsModel(
      foodCalory: caloryController.text,
      foodName: foodNameController.text,
      foodCategory: dropDownValue,
      imageUrl: imageUrl,
    );
    await FirestoreHelper.firestoreHelper.addFoodToFoodListToTheUser(
        foodDetailsModel, SpHelper.spHelper.getUserInfo().email);
    AppRouter.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
        builder: (context, firestoreProvider, x) {
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
                                  controller: foodNameController,
                                  decoration: detailsInputDecorationWidget()),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              height: 35.h,
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: DropdownButton(
                                  iconDisabledColor: Colors.blue,
                                  iconEnabledColor: Colors.blue,
                                  underline: const SizedBox(),
                                  value: dropDownValue,
                                  isExpanded: true,
                                  items: categories.map((e) {
                                    return DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    );
                                  }).toList(),
                                  onChanged: (v) {
                                    dropDownValue = v;
                                    setState(() {});
                                  },
                                ),
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
                                        controller: caloryController,
                                        decoration:
                                            detailsInputDecorationWidget()),
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
                  child: firestoreProvider.file != null
                      ? Image.file(firestoreProvider.file, fit: BoxFit.cover)
                      : const Center(
                          child: Icon(
                            Icons.camera_enhance,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
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
                      child: buttonWidget('Upload Photo', () {
                        firestoreProvider.selectFile();
                      }),
                      flex: 2,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: buttonWidget('Save', () async {
                        imageUrl = await FirestorageHelper.firestorageHelper
                            .uploadImage(firestoreProvider.file);
                        firestoreProvider.file = null;
                        save();
                      }),
                      flex: 1,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
