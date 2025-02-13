import 'package:get/get.dart';
import 'package:mombien_test/config_test/data/repositories/categories/category_repository.dart';
import 'package:mombien_test/config_test/features/annonces/models/category_model.dart';
import 'package:mombien_test/config_test/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;

  // Catégorie sélectionnée
  RxString selectedCategory = ''.obs;
  // Liste des catégories
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Charger les catégories
  Future<void> fetchCategories() async {
    try {
      // Montrer le chargement pendant la recherche des catégories
      isLoading.value = true;

      //Lire les catégories de la sources
      final categories = await _categoryRepository.getAllCategories();

      //Mettre à jour la liste des catégories
      allCategories.assignAll(categories);

      //Filtrer les catégories Featured
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh désolé!', message: e.toString());
    } finally {
      // Supprimer le chargement
      isLoading.value = false;
    }
  }

  // Initialiser la sélection
  void setInitialCategory() {
    if (allCategories.isNotEmpty) {
      selectedCategory.value =
          allCategories.first.name; // Première valeur par défaut
    }
  }

  // Mettre à jour la catégorie sélectionnée
  void updateSelectedCategory(String? value) {
    if (value != null) {
      selectedCategory.value = value;
    }
  }
}
