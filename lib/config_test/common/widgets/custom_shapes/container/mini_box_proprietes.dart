import 'package:flutter/material.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/buttons/add_favoris.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/container/model_owner.dart';
import 'package:mombien_test/config_test/features/annonces/models/details_annonces.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/propriete_model.dart';
import 'package:mombien_test/core.dart';

class TOwnPropriete extends StatelessWidget {
  const TOwnPropriete({
    super.key,
    this.showStatus = true,
    this.showAction = false,
    this.onTap,
    required this.property,
  });

  final bool showStatus;
  final bool showAction;
  final PropertiesModel property;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(PropertiesController());
    final dark = THelperFunctions.isDarkMode(context);
    final List<TDetailsModel> details = [
      TDetailsModel(icon: Icons.bathtub, detail: '${property.showers} '),
      TDetailsModel(icon: Icons.bed, detail: '${property.rooms}'),
      TDetailsModel(icon: Icons.living, detail: '${property.livingRoom} '),
      TDetailsModel(icon: Icons.square_foot, detail: '${property.area} m²'),
    ];
    return Stack(
      children: [
        TModelOwner(
            onTap: onTap,
            dark: dark,
            thumbnail: property.thumbnail,
            title: property.title,
            subTitle: property.subTitle,
            details: details,
            owner: property.owner),
        if (showStatus)
          Positioned(
            bottom: 16,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: TColors.success,
                  borderRadius: BorderRadius.circular(TSizes.buttonWidth)),
              child: Text(
                property.status,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: TColors.white)
                    .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        if (showAction)
          Positioned(
              top: 20,
              right: 8,
              child: TAddFavoris(
                size: 18,
                propertyId: property.id!,
              ))
      ],
    );
  }
}
