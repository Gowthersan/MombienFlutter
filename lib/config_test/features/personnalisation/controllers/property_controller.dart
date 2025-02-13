import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mombien_test/config_test/data/repositories/authentification/authentication_repository.dart';
import 'package:mombien_test/config_test/data/repositories/proprietes/properties_repository.dart';
import 'package:mombien_test/config_test/features/annonces/controllers/category_controller.dart';
import 'package:mombien_test/config_test/features/personnalisation/controllers/user_controller.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/propriete_model.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/status_types.dart';
import 'package:mombien_test/config_test/utils/helpers/network_manager.dart';
import 'package:mombien_test/config_test/utils/popups/full_screen_loader.dart';
import 'package:mombien_test/config_test/utils/popups/loaders.dart';
import 'package:mombien_test/core.dart';

class PropertiesController extends GetxController {
  static PropertiesController get instance => Get.find();

  // Variables observables
  final imageUploading = false.obs;
  final isLoading = false.obs;
  final Rx<PropertiesModel> property = PropertiesModel.empty().obs;
  final Rx<PropertiesModel> selectedProperty = PropertiesModel.empty().obs;

  final propertyRepo = Get.put(PropertyRepository());
  final userController = Get.put(UserController());
  RxList<PropertiesModel> allProperties =
      <PropertiesModel>[].obs; // Liste de toutes les proprietés

  RxBool imagesReadyForSave = false.obs; // Observable boolean
  final RxList<XFile> selectedImages = RxList<
      XFile>(); // Observable list  // Indique si les images sont prêtes à être sauvegardées

  // Controllers pour chaque champ
  final title = TextEditingController();
  final subTitle = TextEditingController();
  final description = TextEditingController();
  final rooms = TextEditingController();
  final area = TextEditingController();
  final floors = TextEditingController();
  final price = TextEditingController();
  final showers = TextEditingController();
  final livingRoom = TextEditingController();
  final category = Get.put(CategoryController());
  final status = Get.put(StatusDropdownController());

  // Clé de formulaire pour la validation
  GlobalKey<FormState> propertiesFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchPropertyDetails();
  }

  Future<void> fetchPropertyDetails() async {
    try {
      isLoading.value = true;
      final properties = await propertyRepo.getAllProperties();
      // final property = await propertyRepo.fetchPropertyDetails();
      allProperties.assignAll(properties);
      // this.property(property);
    } catch (e) {
      property(PropertiesModel.empty());
    } finally {
      isLoading.value = false;
    }
  }

  void selectProperty(PropertiesModel property) {
    selectedProperty.value = property;
  }

  Future<void> createProperty(PropertiesModel property) async {
    try {
      //Commencer le chargement
      TFullScreenLoader.openLoadingDialog(
          'Nous enregistrons vos informations...', TImages.docerAnimation);

      //Vérifier la connexion internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Fermer le chargement
        TFullScreenLoader.stopLoading();
        return;
      }

      //Validation qui verifie le formulaire et si les valeurs sont bien correctes si non ils retourne des erreurs
      if (!propertiesFormKey.currentState!.validate()) {
        //Fermer le chargement
        TFullScreenLoader.stopLoading();
        return;
      }

      final imagesUrls = await getImagesUrls(property.id);
      final thumbnailUrl = imagesUrls.first;

      final newProperty = PropertiesModel(
        id: property.id!,
        title: title.text.trim(),
        subTitle: subTitle.text.trim(),
        description: description.text.trim(),
        thumbnail: thumbnailUrl,
        images: imagesUrls,
        rating: 0,
        rooms: int.parse(rooms.text.trim()),
        area: double.parse(area.text.trim()),
        floors: int.parse(floors.text.trim()),
        price: double.parse(price.text.trim()),
        showers: int.parse(showers.text.trim()),
        livingRoom: int.parse(livingRoom.text.trim()),
        category: category.selectedCategory.value,
        status: status.selectedStatus.value,
        owner: userController.user.value.username,
      );

      // Envoyer les images à Firebase Storage et enregistrer les données dans le FireStore
      await propertyRepo.savePropertyRecord(newProperty);

      //Fermer le chargement
      TFullScreenLoader.stopLoading();

      //Aller vers la page de succès
      Get.off(() => SucessScreen(
            image: TImages.successfullyRegisterAnimation,
            title: 'Ajouté avec succès',
            subTitle:
                'Votre bien a été ajouté avec succès ! Consulter vos propriétés sur votre inventaire maintenant !',
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));

      TLoaders.successSnackBar(
          title: 'Succès', message: 'Sauvegarde effectuée');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Erreur',
        message: 'Les données n’ont pas pu être sauvegardées. ${e.toString()}',
      );
    }
  }

  Future<List<XFile>> pickImages() async {
    try {
      // Simulation d'un délai
      // Sélectionner jusqu'à 5 images
      final pickedImages = await ImagePicker().pickMultiImage(
        imageQuality: 70,
      );

      // Vérification si des images sont sélectionnées
      if (pickedImages.isEmpty) {
        TLoaders.errorSnackBar(title: 'Aucune image sélectionnée.');
        return [];
      } else {
        // Limiter à 5 images
        if (pickedImages.length > 5) {
          TLoaders.errorSnackBar(
              title: 'Vous ne pouvez pas importer plus de 5 images.');
          return [];
        }

        if (pickedImages.isNotEmpty) {
          imageUploading.value = true;
          await Future.delayed(const Duration(seconds: 2));
          // selectedImages.clear();
          selectedImages.addAll(pickedImages);
        }
        update();

        return selectedImages;
      }
    } catch (error) {
      // Gestion des erreurs
      TLoaders.errorSnackBar(
        title: 'Erreur',
        message: 'Veuillez réessayer ! Les images ont un problème',
      );
      return [];
    } finally {
      imageUploading.value = false;
      // imagesReadyForSave.value = false;
    }
  }

  // Méthode pour supprimer une image de la liste
  void deleteImage(int index, VoidCallback callback) {
    selectedImages.removeAt(index);
    callback();
    if (selectedImages.isEmpty) {
      imageUploading.value = false;
      imagesReadyForSave.value = false;
    }
  }

  void refreshImages() {
    refresh();
  }

  Future<List<String>> getImagesUrls(String? propertyId) async {
    try {
      // final images = await setImages();

      final RxList<XFile> imageList = RxList.from(selectedImages);
      List<String> imageUrls = [];

      for (XFile image in imageList) {
        if (imageList.isNotEmpty) {
          imageUploading.value = true;
          const folderPath = 'Properties/Images/';
          final imageUrl = await propertyRepo.uploadImage(folderPath, image);

          imageUrls.add(imageUrl);
        }
      }

      return imageUrls;
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Erreur',
        message: 'Une erreur s\'est produite. Veuillez réessayer.',
      );
      return [];
    } finally {
      imageUploading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    // Fetch the latest data from the server or update the properties
    // based on the current state
    await propertyRepo.fetchPropertyDetails();
    update();
  }
}
