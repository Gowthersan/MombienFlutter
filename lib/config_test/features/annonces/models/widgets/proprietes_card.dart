import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mombien_test/config_test/features/annonces/screens/home/widgets/annonces.dart';
import 'package:mombien_test/config_test/utils/constants/colors.dart';
import 'package:mombien_test/config_test/utils/constants/sizes.dart';

class TProprietesCard extends StatelessWidget {
  const TProprietesCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subTitle,
    required this.showers,
    required this.rooms,
    required this.rating,
    required this.price,
    required this.id,
    this.onTap,
    // required this.property,
  });

  // final PropertiesModel property;
  final String thumbnail, title, subTitle, id;
  final int showers, rooms;
  final double rating, price;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // final propertyController = Get.put(PropertiesController());
    return GestureDetector(
      // onTap: () {},
      onTap: onTap,
      child: Stack(
        children: [
          TModelAnnonces(
              thumbnail: thumbnail,
              title: title,
              subTitle: subTitle,
              showers: showers,
              id: id,
              rooms: showers),
          Positioned(
            bottom: 14,
            left: 12,
            child: Container(
              padding: const EdgeInsets.all(12),
              width: 180,
              // height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                color: TColors.primary,
              ),
              child: Text(
                '\$$price - \$${price / 10}/mois',
                maxLines: 1,
                overflow: TextOverflow.ellipsis, //Afficher le prix
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: TColors.light),
              ),
            ),
          ),
          Positioned(
              bottom: 24,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$rating',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.black),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  const Icon(
                    Iconsax.star1,
                    color: Color.fromARGB(255, 235, 198, 15),
                    size: 24,
                  ),
                ],
              ) // Détails du bien par le nombre de chambre et de douche
              ),
        ],
      ),
    );
  }
}
