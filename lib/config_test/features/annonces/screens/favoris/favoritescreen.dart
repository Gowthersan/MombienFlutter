import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mombien_test/config_test/common/widgets/appbar/appbar.dart';
import 'package:mombien_test/config_test/common/widgets/custom_shapes/container/mini_box_proprietes.dart';
import 'package:mombien_test/config_test/common/widgets/loaders/animation_loader.dart';
import 'package:mombien_test/config_test/common/widgets/products/chat/notification_menu_icon.dart';
import 'package:mombien_test/config_test/common/widgets/shimmers/shimmer.dart';
import 'package:mombien_test/config_test/features/annonces/controllers/favoris_controller.dart';
import 'package:mombien_test/config_test/features/annonces/screens/proprietes/details_proprietes_page.dart';
import 'package:mombien_test/core.dart';

class Favoritescreen extends StatelessWidget {
  const Favoritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Favoris', style: Theme.of(context).textTheme.headlineMedium),
        action: [
          TNotifCounterIcon(
              onPressed: () {},
              icon: Iconsax.add,
              size: 28,
              showNotification: false)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace - 8),
          child: Column(
            children: [
              Obx(() => FutureBuilder(
                  future: controller.favoritesProperties(),
                  builder: (context, snapshot) {
                    final emptyWidget = TAnimationLoaderWidget(
                      text: 'Oups ! Il n\'y a rien dans vos favoris...',
                      animation: TImages.pencilAnimation,
                      showAction: true,
                      actionText: 'Ajoutons en maintenant !',
                      onActionPressed: () =>
                          Get.off(() => const NavigationMenu()),
                    );

                    const loarder = TVerticalPropertiesShimmer(
                      itemCount: 4,
                    );

                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loarder,
                        nothingFound: emptyWidget);

                    if (widget != null) return widget;

                    final properties = snapshot.data!;

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        // final property = favoriteProperties[index];
                        final dark = THelperFunctions.isDarkMode(context);
                        final isLastItem = index == properties.length - 1;

                        return Column(
                          children: [
                            TOwnPropriete(
                              property: properties[index],
                              onTap: () => Get.to(
                                () => TDetailsProprietesPage(
                                    property: properties[index]),
                                transition: Transition.rightToLeft,
                              ),
                              showStatus: false,
                              showAction: true,
                            ),
                            if (!isLastItem)
                              Divider(
                                color: dark ? TColors.grey : TColors.darkerGrey,
                                thickness: 0.5,
                                indent: 15,
                                endIndent: 15,
                              ),
                          ],
                        );
                      },
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }
}

class TVerticalPropertiesShimmer extends StatelessWidget {
  const TVerticalPropertiesShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TShimmerEffect(width: double.infinity, height: 138),
              SizedBox(height: 10),
            ],
          )),
    );
  }
}
