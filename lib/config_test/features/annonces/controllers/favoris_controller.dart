import 'dart:convert';

import 'package:get/get.dart';
import 'package:mombien_test/config_test/data/repositories/proprietes/properties_repository.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/propriete_model.dart';
import 'package:mombien_test/config_test/utils/local_storage/storage_utility.dart';
import 'package:mombien_test/config_test/utils/popups/loaders.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  /// Variables

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch favorite data from the API or database
    initFavorites();
  }

  Future<void> initFavorites() async {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String propertyId) {
    return favorites[propertyId] ?? false;
  }

  void toggleFavoriteProperty(String propertyId) {
    if (!favorites.containsKey(propertyId)) {
      favorites[propertyId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Le bien a été ajouté à vos favoris');
    } else {
      TLocalStorage.instance().removeData(propertyId);
      favorites.remove(propertyId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Un bien a été supprimé de vos favoris');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<PropertiesModel>> favoritesProperties() async {
    return await PropertyRepository.instance
        .getFavoritesProperties(favorites.keys.toList());
  }
}
