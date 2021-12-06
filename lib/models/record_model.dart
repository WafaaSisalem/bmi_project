import 'package:bmi_calculator_project/helpers/firestore_helper.dart';
import 'package:intl/src/intl/date_format.dart';
class RecordModel {
  double weight;
  double length;
  String recordCategory;
  String currentStatusAsString;
  double currentStatusAsDouble;
  RecordModel.fromMap(Map map) {
    weight = map[FirestoreHelper.weightKey];
    length = map[FirestoreHelper.lengthKey];
    recordCategory = map[FirestoreHelper.recordCategoryKey];
    currentStatusAsString = map[FirestoreHelper.currentStatusAsStringKey];
    currentStatusAsDouble = map[FirestoreHelper.currentStatusAsDoubleKey];
  }
  RecordModel({this.weight, this.length, this.currentStatusAsString, this.currentStatusAsDouble,this.recordCategory});
  toMap() {
    return {
      FirestoreHelper.weightKey: weight,
      FirestoreHelper.lengthKey: length,
      FirestoreHelper.dateOfAddingKey: DateTime.now(),
      FirestoreHelper.dateFormatedKey:  DateFormat.yMMMMd().format(DateTime.now()),
      FirestoreHelper.currentStatusAsStringKey: currentStatusAsString,
      FirestoreHelper.currentStatusAsDoubleKey: currentStatusAsDouble,
      FirestoreHelper.recordCategoryKey:recordCategory
    };
  }
}
