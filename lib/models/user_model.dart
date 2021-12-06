import 'package:bmi_calculator_project/helpers/firestore_helper.dart';

class UserModel {
  // String id;
  String email;
  String userName;
  String gender;
  String dateOfBirth;
  String currentStatus;
  UserModel.fromMap(Map map) {
    // id = map['id'];
    email = map[FirestoreHelper.emailKey];
    userName = map[FirestoreHelper.userNameKey];
    gender = map[FirestoreHelper.genderKey];
    dateOfBirth = map[FirestoreHelper.dateOfBirthKey];
    currentStatus = map[FirestoreHelper.currentStatusKey];
  }
  UserModel({
    this.email,
    this.userName,
    this.gender,
    this.dateOfBirth,
    this.currentStatus,
  });
  toMap() {
    return {
      // 'id': id,
      FirestoreHelper.emailKey: email,
      FirestoreHelper.userNameKey: userName,
      FirestoreHelper.genderKey: gender,
      FirestoreHelper.dateOfBirthKey: dateOfBirth,
      FirestoreHelper.currentStatusKey: currentStatus,
    };
  }
}
