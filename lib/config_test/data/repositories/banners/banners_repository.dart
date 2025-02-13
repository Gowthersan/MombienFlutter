import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mombien_test/config_test/features/annonces/models/banner_model.dart';
import 'package:mombien_test/config_test/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/firebase_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/format_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs.map((doc) => BannerModel.fromSnapchot(doc)).toList();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme lors de la lectures des bannières. Veuillez reessayer.';
    }
  }
}
