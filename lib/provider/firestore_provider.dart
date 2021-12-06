import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreProvider extends ChangeNotifier {
  String currentStatus;
  QuerySnapshot<Map<String, dynamic>> querySnapshot;
  initCurrentStatus() async {
    querySnapshot = await getUserRecords();
    currentStatus =
        querySnapshot.docs.last.data()[FirestoreHelper.currentStatusKey];
    notifyListeners();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserRecords() async {
    return await FirestoreHelper.firestoreHelper
        .getUserRecordsById(SpHelper.spHelper.getUserInfo().email);
  }
}
