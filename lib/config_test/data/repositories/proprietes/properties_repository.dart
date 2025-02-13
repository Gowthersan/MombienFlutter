import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/propriete_model.dart';
import 'package:mombien_test/config_test/utils/exceptions/firebase_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/format_exceptions.dart';
import 'package:mombien_test/config_test/utils/exceptions/platform_exceptions.dart';
import 'package:uuid/uuid.dart' show Uuid;

class PropertyRepository extends GetxController {
  static PropertyRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fonction pour ajouter une propriété dans Firestore
  Future<void> savePropertyRecord(
    PropertiesModel property,
  ) async {
    try {
      await _db.collection("Properties").add(property.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un problème. Veuillez réessayer.';
    }
  }

  Future<PropertiesModel> fetchPropertyDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Properties")
          .doc(FirebaseFirestore.instance.collection('Properties').doc().id)
          .get();
      if (documentSnapshot.exists) {
        return PropertiesModel.fromSnapshot(documentSnapshot);
      } else {
        return PropertiesModel.empty(); // Propriété non trouvée
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme. Veuillez reessayer.';
    }
  }

  // Fonction pour mettre à jour une bien
  Future<void> updatePropertyDetails(PropertiesModel updateProperty) async {
    try {
      await _db
          .collection("Properties")
          .doc(updateProperty.id)
          .update(updateProperty.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme. Veuillez reessayer.';
    }
  }

  // Fonction pour récupérer toutes les propriétés
  Future<List<PropertiesModel>> getAllProperties() async {
    try {
      final snapshot = await _db.collection("Properties").get();
      final list = snapshot.docs
          .map((doc) => PropertiesModel.fromSnapshot(doc))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme. Veuillez reessayer.';
    }
  }

  Future<List<PropertiesModel>> getFavoritesProperties(
      List<String> propertyId) async {
    try {
      final snapshot = await _db
          .collection("Properties")
          .where(FieldPath.documentId, whereIn: propertyId)
          .get();
      return snapshot.docs
          .map((querySnapshot) => PropertiesModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme. Veuillez reessayer.';
    }
  }

  // Fonction pour récupérer une propriété par son ID
  Future<PropertiesModel?> getPropertyById(
    PropertiesModel property,
  ) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection("Properties").doc(property.id).get();
      if (snapshot.exists) {
        return PropertiesModel.fromSnapshot(snapshot);
      }
      return PropertiesModel.empty(); // Propriété non trouvée
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme. Veuillez reessayer.';
    }
  }

  //Fonction pour mettre à jour un seul champ
  Future<void> updatePSingleField(
      Map<String, dynamic> json, String propertyId) async {
    try {
      // Mettre à jour le document avec les champs fournis
      await _db.collection("Properties").doc(propertyId).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un problème. Veuillez réessayer.';
    }
  }

  // Fonction pour supprimer une propriété
  Future<void> deleteProperty(
    String propertyId,
  ) async {
    try {
      await _db.collection("Properties").doc(propertyId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme. Veuillez reessayer.';
    }
  }

  //Importer des photos dans Firestore
  Future<String> uploadImage(String folderPath, XFile image) async {
    try {
      // Générer un nom de fichier unique avec extension
      const uuid = Uuid();
      final extension = image.path.split('.').last;
      final fileName = '${uuid.v4()}.$extension';

      // Référence vers Firebase Storage avec le chemin complet
      final ref = FirebaseStorage.instance.ref().child('$folderPath/$fileName');

      // Téléverser le fichier
      await ref.putFile(File(image.path));

      // Récupérer l'URL de téléchargement
      final downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'On dirait qu\'il y a un probleme. Veuillez reessayer.';
    }
  }
}
