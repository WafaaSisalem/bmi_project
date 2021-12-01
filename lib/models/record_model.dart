import 'package:bmi_calculator_project/helpers/firestore_helper.dart';

class RecordModel {
  double weight;
  double length;
  String currentStatus;
  RecordModel.fromMap(Map map) {
    weight = map[FirestoreHelper.weightKey];
    length = map[FirestoreHelper.lengthKey];
    currentStatus = map[FirestoreHelper.currentStatusKey];
  }
  RecordModel({this.weight, this.length, this.currentStatus});
  toMap() {
    return {
      FirestoreHelper.weightKey: weight,
      FirestoreHelper.lengthKey: length,
      FirestoreHelper.dateOfAddingKey: DateTime.now(),
      FirestoreHelper.currentStatusKey: currentStatus
    };
  }
}
