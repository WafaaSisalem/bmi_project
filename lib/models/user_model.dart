import 'package:bmi_calculator_project/helpers/firestore_helper.dart';

class UserModel {
  // String id;
  String email;
  String userName;
  UserModel.fromMap(Map map) {
    // id = map['id'];
    email = map[FirestoreHelper.emailKey];
    userName = map[FirestoreHelper.userNameKey];
  }
  UserModel({this.email, this.userName});
  toMap() {
    return {
      // 'id': id,
      FirestoreHelper.emailKey: email,
      FirestoreHelper.userNameKey: userName
    };
  }
}
