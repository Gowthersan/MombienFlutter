import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/buttons/add_favoris.dart';
import 'package:mombien_test/config_test/common/widgets/shimmers/shimmer.dart';
import 'package:mombien_test/config_test/features/annonces/models/widgets/details_proprietes.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/propriete_model.dart';
import 'package:mombien_test/config_test/utils/constants/colors.dart';
import 'package:mombien_test/config_test/utils/constants/sizes.dart';

class TPAnnonces extends StatelessWidget {
  const TPAnnonces({
    super.key,
    required this.thumbnail,
    required this.price,
    required this.rating,
    required this.title,
    required this.subTitle,
    required this.rooms,
    required this.showers,
    this.onTap,
    required this.property,
    // required this.property,
  });

  final PropertiesModel property;
  final String thumbnail;
  final double price, rating;
  final String title, subTitle;
  final int rooms, showers;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // final propertyController = Get.put(PropertiesController());

    return GestureDetector(
      // onTap: () {},
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 400,
          padding: const EdgeInsets.all(TSizes.defaultSpace - 15),
          margin: const EdgeInsets.only(right: 8, top: 12, bottom: 12),
          decoration: BoxDecoration(
              color: TColors.grey,
              borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      // color: overlayColor,
                      imageUrl: thumbnail,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const TShimmerEffect(
                                  width: double.infinity,
                                  height: 100,
                                  radius: 12),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: TAddFavoris(
                      size: 28,
                      propertyId: property.id!,
                    ), // Ajoutez le bien dans les favoris
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: TDetailsProprietesCard(
                        showers: showers,
                        rooms:
                            rooms), // Détails du bien par le nombre de chambre et de douche
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: TColors.black)
                    .copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: TSizes.fontSizeMd),
              ),
              const SizedBox(
                height: TSizes.xs,
              ),
              Text(
                subTitle,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: TColors.black),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: 190,
                    // height: 24,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusLg),
                      color: TColors.primary,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '\$$price - \$${price / 10}/mois', //Afficher le prix
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: TColors.light),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$rating',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: TColors.black),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Iconsax.star1,
                        color: Color.fromARGB(255, 235, 198, 15),
                        size: 24,
                      ),
                    ],
                  ) // Dét
                ],
              ),
            ],
          )),
    );
  }
}
