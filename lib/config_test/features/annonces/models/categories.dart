import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCategoriesModel {
  String title;
  IconData icon;
  TCategoriesModel({
    required this.title,
    required this.icon,
  });
}

List<TCategoriesModel> categories = [
  TCategoriesModel(title: 'Maison', icon: Iconsax.house),
  TCategoriesModel(title: 'Villa', icon: Iconsax.house_2),
  TCategoriesModel(title: 'Studio', icon: Iconsax.house_2),
  TCategoriesModel(title: 'Immeuble', icon: Iconsax.buildings_2),
  TCategoriesModel(title: 'Bureau', icon: Iconsax.buliding),
  TCategoriesModel(title: 'Appartement', icon: Iconsax.buildings),
];
