import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mombien_test/config_test/common/widgets/shimmers/shimmer.dart';
import 'package:mombien_test/config_test/features/annonces/models/widgets/proprietes_card.dart';
import 'package:mombien_test/config_test/features/annonces/screens/proprietes/details_proprietes_page.dart';
import 'package:mombien_test/config_test/features/personnalisation/controllers/property_controller.dart';

class TRecommandations extends StatelessWidget {
  const TRecommandations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final propertyController = Get.put(PropertiesController());
    return Obx(() {
      if (propertyController.isLoading.value) {
        return const TShimmerEffect(width: double.infinity, height: 300);
      }

      if (propertyController.allProperties.isEmpty) {
        return const Text('Aucune annonce');
      }

      return SizedBox(
        height: 350,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: propertyController.allProperties.length,
          itemBuilder: (BuildContext context, int index) {
            final property = propertyController.allProperties[index];
            return TProprietesCard(
              id: property.id!,
              title: property.title,
              thumbnail: property.thumbnail,
              subTitle: property.subTitle,
              price: property.price,
              showers: property.showers,
              rooms: property.rooms,
              rating: property.rating,
              onTap: () => Get.to(
                () => TDetailsProprietesPage(property: property),
                transition: Transition.rightToLeft,
              ),
            );
          },
        ),
      );
    });
  }
}
