import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mombien_test/config_test/features/annonces/models/category_model.dart';
import 'package:mombien_test/config_test/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/firebase_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/format_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //Variables
  final _db = FirebaseFirestore.instance;

  //Methods

  //Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme lors de la lectures des catégories. Veuillez reessayer.';
    }
  }

  //Get sub categories

  //upload categories to Firebase
}
