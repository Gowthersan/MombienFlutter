import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/container/new_annonce.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/container/search_container.dart';
import 'package:mombien_test/config_test/common/widgets/texts/section_heading.dart';
import 'package:mombien_test/config_test/features/annonces/screens/proprietes/details_proprietes_page.dart';
import 'package:mombien_test/config_test/features/personnalisation/controllers/property_controller.dart';
import 'package:mombien_test/config_test/utils/constants/colors.dart';
import 'package:mombien_test/config_test/utils/constants/sizes.dart';
import 'package:mombien_test/config_test/utils/helpers/helper_functions.dart';

class TCategoriesPage extends StatelessWidget {
  // final TCategoriesModel categoryModel;

  const TCategoriesPage({
    super.key,
    required this.name,

    // required this.categoryModel,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.black : TColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace - 22),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(height: TSizes.defaultSpace * 5, width: 4),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Iconsax.arrow_left,
                          color: dark ? TColors.white : TColors.black),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(
                            color: dark ? TColors.white : TColors.black,
                          )
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Column(
                  children: [
                    TSchearchContainer(
                        text: 'Recherchez villes, rues,...', onTap: () {}),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Padding(
                  padding: const EdgeInsets.only(
                    top: TSizes.defaultSpace - 10,
                    left: TSizes.defaultSpace,
                    right: TSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      const TSectionHeading(
                          title: 'Populaires', showActionButton: true),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      // Utilisation de GetBuilder pour reconstruire uniquement cette partie
                      GetBuilder<PropertiesController>(
                        builder: (controller) {
                          final filteredProperties =
                              controller.allProperties.where((property) {
                            return property.category == name;
                          }).toList();

                          if (filteredProperties.isEmpty) {
                            return const Center(
                                child: Text(
                                    "Aucune annonce pour cette catégorie"));
                          }

                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredProperties.length,
                            itemBuilder: (BuildContext context, int index) {
                              final property = filteredProperties[index];
                              return TPAnnonces(
                                  thumbnail: property.thumbnail,
                                  showers: property.showers,
                                  rooms: property.rooms,
                                  price: property.price,
                                  title: property.title,
                                  subTitle: property.subTitle,
                                  rating: property.rating,
                                  property: property,
                                  onTap: () => Get.to(
                                        () => TDetailsProprietesPage(
                                            property: property),
                                        transition: Transition.rightToLeft,
                                      ));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
