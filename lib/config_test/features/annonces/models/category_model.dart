import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryModel {
  String id;
  String name;
  IconData icon;
  bool isFeatured;
  String parentId;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.parentId,
      required this.icon,
      this.isFeatured = false});

  //Empty model
  static CategoryModel empty() => CategoryModel(
      id: '',
      name: '',
      icon: Icons.question_answer,
      isFeatured: false,
      parentId: '');

  //Convertir le modèle en JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Icon': icon.toString(),
      'isFeatured': isFeatured,
      'ParentId': parentId
    };
  }

  //Créer un modèle à partir de JSON
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      IconData getIconForCategory(String categoryName) {
        switch (categoryName) {
          case 'Maison':
            return Iconsax.house;
          case 'Villa':
            return Iconsax.house_2;
          case 'Studio':
            return Iconsax.house_2;
          case 'Immeuble':
            return Iconsax.buildings_2;
          case 'Bureau':
            return Iconsax.building;
          case 'Appartement':
            return Iconsax.buildings;
          default:
            return Icons.question_answer; // Icône par défaut
        }
      }

      // Map JSON record to the Model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        icon: getIconForCategory(data['Name'] as String),
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['ParentId'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
