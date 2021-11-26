import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static const String userCollectionName = 'users';
  static const String userNameKey = 'userName';
  static const String emailKey = 'email';

  addUserToFirestore(userMap) async {
    try {
      await firebaseFirestore.collection(userCollectionName).add(userMap);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getUserByUsername(userName) async {
    return await firebaseFirestore
        .collection(userCollectionName)
        .where(userNameKey, isEqualTo: userName)
        .get();
  }

  getUserByEmail(email) async {
    return await firebaseFirestore
        .collection(userCollectionName)
        .where(emailKey, isEqualTo: email)
        .get();
  }
}
