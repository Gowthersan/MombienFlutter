import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/buttons/add_favoris.dart';
import 'package:mombien_test/config_test/common/widgets/shimmers/shimmer.dart';
import 'package:mombien_test/config_test/features/annonces/models/widgets/details_proprietes.dart';
import 'package:mombien_test/config_test/utils/constants/colors.dart';
import 'package:mombien_test/config_test/utils/constants/sizes.dart';
import 'package:mombien_test/config_test/utils/helpers/helper_functions.dart';

class TModelAnnonces extends StatelessWidget {
  const TModelAnnonces({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subTitle,
    required this.rooms,
    required this.showers,
    required this.id,
    // required this.property,
  });

  // final PropertiesModel? property;
  final String thumbnail, title, subTitle;
  final int rooms, showers;
  final String id;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    // final propertyController = Get.put(PropertiesController());
    return Container(
        width: 270,
        padding: const EdgeInsets.all(TSizes.defaultSpace - 15),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: dark ? TColors.darkGrey : TColors.grey,
            borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    // fit: fit,
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
                    propertyId: id,
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
                      fontWeight: FontWeight.bold, fontSize: TSizes.fontSizeMd),
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
          ],
        ));
  }
}
