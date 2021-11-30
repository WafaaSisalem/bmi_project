import 'package:bmi_calculator_project/helpers/firestore_helper.dart';

class UserModel {
  // String id;
  String email;
  String userName;
  String gender;
  double weight;
  double length;
  String dateOfBirth;
  UserModel.fromMap(Map map) {
    // id = map['id'];
    email = map[FirestoreHelper.emailKey];
    userName = map[FirestoreHelper.userNameKey];
    gender = map[FirestoreHelper.genderKey];
    weight = map[FirestoreHelper.weightKey];
    length = map[FirestoreHelper.lengthKey];
    dateOfBirth = map[FirestoreHelper.dateOfBirthKey];
  }
  UserModel(
      {this.email,
      this.userName,
      this.gender,
      this.weight,
      this.length,
      this.dateOfBirth});
  toMap() {
    return {
      // 'id': id,
      FirestoreHelper.emailKey: email,
      FirestoreHelper.userNameKey: userName,
      FirestoreHelper.genderKey: gender,
      FirestoreHelper.weightKey: weight,
      FirestoreHelper.lengthKey: length,
      FirestoreHelper.dateOfBirthKey: dateOfBirth
    };
  }
}
