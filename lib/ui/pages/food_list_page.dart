import 'package:bmi_calculator_project/helpers/firestorage_helper.dart';
import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/models/food_details_model.dart';
import 'package:bmi_calculator_project/provider/firestore_provider.dart';
import 'package:bmi_calculator_project/router/app_router.dart';
import 'package:bmi_calculator_project/ui/pages/edit_food_details.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FoodListPage extends StatefulWidget {
  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FirestoreProvider>(context, listen: false).initUserFoodList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
        builder: (context, firestoreProvider, x) {
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
              firestoreProvider.queryFoodSnapshot != null &&
                      firestoreProvider.queryFoodSnapshot.docs.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 30.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          Map<String, dynamic> foods = firestoreProvider
                              .queryFoodSnapshot.docs.reversed.toList()[index]
                              .data();
                          dynamic docId = firestoreProvider
                              .queryFoodSnapshot.docs.reversed.toList()[index].id;

                          return foodListItem(FoodDetailsModel.fromMap(foods),
                              () {
                            firestoreProvider.deleteFoodFromFoodList(docId);
                          }, () {
                            AppRouter.router.pushFunction(EditFoodDetails(
                                FoodDetailsModel.fromMap(foods), docId));
                          });
                        },
                        itemCount:
                            firestoreProvider.queryFoodSnapshot.docs.length,
                      ),
                    )
                  : const Center(
                      child: Text('No Food Added Yet!'),
                    )
            ],
          ),
        ),
      );
    });
  }
}
