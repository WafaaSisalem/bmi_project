import 'package:bmi_calculator_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelper = SpHelper._();
  SharedPreferences prefs;
  static const String loggedINKey = 'ISLOGGEDIN';
  static const String userNameKey = 'USERNAME';
  static const String emailKey = 'EMAILKEY';
  static const String currentStatusKey = 'CURRENTSTATUS';
  static const String genderKey = 'GENDER';
  static const String dateOfBirthKey = 'DATEOFBIRTH';
  initSharedPrefrence() async {
    prefs = await SharedPreferences.getInstance();
  }

  setUserLoggedInState(isLoggedIn) => prefs.setBool(loggedINKey, isLoggedIn);
  getUserLoggedInState() {
    if (prefs.getBool(loggedINKey) != null) {
      return prefs.getBool(loggedINKey);
    } else {
      return false;
    }
  }

  setUserInfo(UserModel userModel) {
    prefs.setString(userNameKey, userModel.userName);
    prefs.setString(emailKey, userModel.email);
    prefs.setString(genderKey , userModel.gender);
    prefs.setString(dateOfBirthKey, userModel.dateOfBirth);
  }

  UserModel getUserInfo() {
    return UserModel(
        email: prefs.getString(emailKey),
        userName: prefs.getString(userNameKey),
        gender:  prefs.getString(genderKey),
        dateOfBirth: prefs.getString(dateOfBirthKey));
        
  }

  // setUserCurrentStatus(currentStatus) {
  //   prefs.setString(currentStatusKey, currentStatus);
  // }

  // getUserCurrentStatus() {
  //   return prefs.get(currentStatusKey);
  // }
  clear(){
    prefs.clear();
    print('all cleared');
  }
}
