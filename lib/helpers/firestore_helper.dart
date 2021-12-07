import 'package:bmi_calculator_project/models/food_details_model.dart';
import 'package:bmi_calculator_project/models/record_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static const String userCollectionName = 'users';
  static const String recordsCollectionName = 'records';
  static const String foodsCollectionName = 'foods';
  static const String userNameKey = 'userName';
  static const String emailKey = 'email';
  static const String genderKey = 'gender';
  static const String weightKey = 'weight';
  static const String lengthKey = 'length';
  static const String dateOfBirthKey = 'dateOfBirth';
  static const String dateOfAddingKey = 'dateOfAdding';
  static const String currentStatusAsStringKey = 'currentStatusAsString';
  static const String currentStatusAsDoubleKey = 'currentStatusAsDouble';
  static const String dateFormatedKey = 'dateFormated';
  static const String recordCategoryKey = 'recordCategory';
  static const String imageUrlKey = 'imageUrl';
  static const String foodNameKey = 'foodName';
  static const String foodCaloryKey = 'foodCalory';
  static const String foodCategoryKey = 'foodCategory';

  addUserToFirestore(userMap) async {
    try {
      await firebaseFirestore
          .collection(userCollectionName)
          .doc(userMap[FirestoreHelper.emailKey])
          .set(userMap);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  addRecordToTheUser(RecordModel recordModel, userEmailAsId) async {
    firebaseFirestore
        .collection(userCollectionName)
        .doc(userEmailAsId)
        .collection(recordsCollectionName)
        .add(recordModel.toMap());
  }

  addFoodToFoodListToTheUser(
      FoodDetailsModel foodDetailsModel, userEmailAsId) async {
    firebaseFirestore
        .collection(userCollectionName)
        .doc(userEmailAsId)
        .collection(foodsCollectionName)
        .add(foodDetailsModel.toMap());
  }

  deleteFoodFromFoodList(userEmailAsId, docId) {
    firebaseFirestore
        .collection(userCollectionName)
        .doc(userEmailAsId)
        .collection(foodsCollectionName)
        .doc(docId)
        .delete();
  }

  getUserByUsername(userName) async {
    return await firebaseFirestore
        .collection(userCollectionName)
        .where(userNameKey, isEqualTo: userName)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserByEmail(email) async {
    return await firebaseFirestore
        .collection(userCollectionName)
        .where(emailKey, isEqualTo: email)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserRecordsById(userId) async {
    return await firebaseFirestore
        .collection(userCollectionName)
        .doc(userId)
        .collection(recordsCollectionName)
        .orderBy(FirestoreHelper.dateOfAddingKey)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserFoodListById(
      userId) async {
    return await firebaseFirestore
        .collection(userCollectionName)
        .doc(userId)
        .collection(foodsCollectionName)
        .orderBy(FirestoreHelper.dateOfAddingKey)
        .get();
  }
}
