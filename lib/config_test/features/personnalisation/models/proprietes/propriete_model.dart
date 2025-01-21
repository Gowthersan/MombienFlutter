import 'package:cloud_firestore/cloud_firestore.dart';

class PropertiesModel {
  final String? id; // Identifiant unique pour chaque propriété
  final String title; // Titre de la propriété
  final String subTitle; // Sous-titre ou adresse de la propriété
  final String description; // Description détaillée de la propriété
  String thumbnail; // Chemin de l'image miniature
  List<String> images; // Liste d'images de la propriété
  final int rooms; // Nombre de chambres
  final double area; // Surface en pieds carrés
  final int floors; // Nombre d'étages
  final int showers; // Nombre de douches
  final int livingRoom; // Nombre de salons
  final double price; // Prix de la propriété
  final double rating; // Note de la propriété
  final String category; // Catégorie de la propriété (ex : Villas, Maisons)
  final String
      status; // Statut de la propriété (ex : Acheté, Vendu, En location)
  final String owner; // Propriétaire de la propriété

  // Constructeur
  PropertiesModel({
    this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.thumbnail,
    required this.images,
    required this.rooms,
    required this.area,
    required this.floors,
    required this.price,
    required this.rating,
    required this.showers,
    required this.livingRoom,
    required this.category,
    required this.status,
    required this.owner,
  });

  //Propriété vide
  static PropertiesModel empty() => PropertiesModel(
        id: '',
        title: '',
        subTitle: '',
        description: '',
        thumbnail: '',
        images: [],
        rooms: 0,
        area: 0,
        floors: 0,
        price: 0,
        rating: 0.0,
        showers: 0,
        livingRoom: 0,
        category: '',
        status: '',
        owner: '',
      );

  // Méthode pour convertir le modèle en JSON
  Map<String, dynamic> toJson() => {
        'Title': title,
        'SubTitle': subTitle,
        'Description': description,
        'Thumbnail': thumbnail,
        'Images': images,
        'Rooms': rooms,
        'Area': area,
        'Floors': floors,
        'Price': price,
        'Rating': rating,
        'Showers': showers,
        'LivingRoom': livingRoom,
        'Category': category,
        'Status': status,
        'Owner': owner,
      };

  // Factory method pour créer un PropertiesModel à partir d'un document Firestore
  factory PropertiesModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return PropertiesModel(
        id: document.id,
        title: data['Title'] ?? '',
        subTitle: data['SubTitle'] ?? '',
        description: data['Description'] ?? '',
        thumbnail: data['Thumbnail'] ?? '',
        images: List<String>.from(data['Images'] ?? []),
        rooms: data['Rooms'] ?? 0,
        area: data['Area'] ?? 0,
        floors: data['Floors'] ?? 0,
        price: data['Price'] ?? 0,
        rating: data['Rating'] ?? 0.0,
        showers: data['Showers'] ?? 0,
        livingRoom: data['LivingRoom'] ?? 0,
        category: data['Category'] ?? '',
        status: data['Status'] ?? '',
        owner: data['Owner'] ?? '',
      );
    } else {
      return PropertiesModel.empty();
    }
  }
}
