import 'package:bmi_calculator_project/helpers/shared_preference_helper.dart';
import 'package:bmi_calculator_project/models/user_model.dart';
import 'package:bmi_calculator_project/ui/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(email, password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showCustomDialog('Wrong password provided for that user.');
      }
    }
  }

  signUpWithEmailAndPassword(email, password, userName) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // User user = userCredential.user;
      // return UserModel(email: email, userName: userName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomDialog('You enterd a too weak password please change it');
      } else if (e.code == 'email-already-in-use') {
        showCustomDialog('The account already exists for that email.');
      }
    }
  }

  Future resetPassword(email) async {
    try {
      return await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString() + 'resetPassword');
    }
  }

  Future signOut() async {
    try {
      await firebaseAuth.signOut();
      SpHelper.spHelper.setUserLoggedInState(false);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString() + 'signOut');
    }
  }
}
