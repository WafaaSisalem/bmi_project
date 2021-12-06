import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreProvider extends ChangeNotifier {
  String currentStatusAsString = '';
  double currentStatusAsDouble = 0.0;
  String recordCategory = '';
  QuerySnapshot<Map<String, dynamic>> querySnapshot;
  initCurrentStatus() async {
    querySnapshot = await getUserRecords();
    currentStatusAsString = querySnapshot.docs.last
        .data()[FirestoreHelper.currentStatusAsStringKey];
    recordCategory =
        querySnapshot.docs.last.data()[FirestoreHelper.recordCategoryKey];
    currentStatusAsDouble = querySnapshot.docs.last
        .data()[FirestoreHelper.currentStatusAsDoubleKey];
    notifyListeners();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserRecords() async {
    return await FirestoreHelper.firestoreHelper
        .getUserRecordsById(SpHelper.spHelper.getUserInfo().email);
  }
}
