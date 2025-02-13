import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/buttons/categories_buttons.dart';
import 'package:mombien_test/config_test/common/widgets/shimmers/shimmer.dart';
import 'package:mombien_test/config_test/features/annonces/controllers/category_controller.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) {
        return const TShimmerEffect(
          width: double.infinity,
          height: 75,
          radius: 70,
        );
      }

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'Aucune catégorie en vedette',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.black),
          ),
        );
      }
      return SizedBox(
        height: 75, // Ajuster la hauteur pour accommoder le ListView
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Défilement horizontal
          itemCount: categoryController.featuredCategories.length,
          itemBuilder: (BuildContext context, int index) {
            final category = categoryController.allCategories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 2.0 * 1.5), // Espacement entre les éléments
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.45, // Ajuster la largeur de chaque item
                child: TCategoriesButton(
                  name: category.name,
                  icon: category.icon,
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
