import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mombien_test/config_test/common/widgets/appbar/appbar.dart';
import 'package:mombien_test/config_test/common/widgets/products/chat/notification_menu_icon.dart';
import 'package:mombien_test/config_test/common/widgets/shimmers/shimmer.dart';
import 'package:mombien_test/config_test/features/annonces/screens/proprietes/widgets/images_preview.dart';
import 'package:mombien_test/config_test/features/personnalisation/controllers/property_controller.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/categories_type.dart';
import 'package:mombien_test/config_test/features/personnalisation/models/proprietes/status_types.dart';
import 'package:mombien_test/core.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertiesController());
    // final userController = Get.put(UserController());

    return Scaffold(
        appBar: TAppBar(
          title: Text('Du nouveau...',
              style: Theme.of(context).textTheme.headlineMedium),
          action: [
            TNotifCounterIcon(
                onPressed: () {},
                icon: Iconsax.house,
                size: 28,
                showNotification: false)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  child: Form(
                    key: controller.propertiesFormKey,
                    child: Column(
                      children: [
                        //LES IMAGES
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        GestureDetector(
                          onTap: () async {
                            await controller.pickImages();
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload,
                                      size: 50, color: Colors.grey),
                                  SizedBox(height: 10),
                                  Text(
                                    "Appuyez pour sélectionner jusqu'à 5 images",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        Obx(() {
                          return controller.imageUploading.value
                              ? const TShimmerEffect(
                                  width: double.infinity, height: 80)
                              : const ImagesPreview();
                        }),

                        const SizedBox(height: TSizes.spaceBtwSections),
                        TextFormField(
                          controller: controller.title,
                          validator: (value) => TValidator.validateTitle(value),
                          expands: false,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.house),
                            labelText: 'Nom du bien',
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        TextFormField(
                          controller: controller.subTitle,
                          validator: (value) =>
                              TValidator.validateLocation(value),
                          minLines: 1, // Nombre minimal de lignes
                          maxLines:
                              null, // Laisse le champ s'agrandir indéfiniment
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            labelText: 'Localisation',
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        TextFormField(
                          controller: controller.description,
                          validator: (value) => TValidator.validateEmptyText(
                              'Description', value),
                          minLines: 1, // Nombre minimal de lignes
                          maxLines:
                              null, // Laisse le champ s'agrandir indéfiniment
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.archive_book),
                            labelText: "Saisissez la description ici...",
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.rooms,
                                validator: (value) =>
                                    TValidator.validateRoomCount(value),
                                expands: false,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.bed_outlined),
                                  labelText: 'Chambres',
                                ),
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwInputFields),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.floors,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        'Nombre d\'étages', value),
                                expands: false,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.element_equal),
                                  labelText: 'Etages',
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.showers,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        'Nombre de salle de bain', value),
                                expands: false,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.shower_outlined),
                                  labelText: 'Salles de bain',
                                ),
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwInputFields),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.livingRoom,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        'Nombre de salons', value),
                                expands: false,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.living_outlined),
                                  labelText: 'Salons',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.area,
                          validator: (value) =>
                              TValidator.validateSurfaceArea(value),
                          expands: false,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.maximize_3),
                            labelText: 'Surface',
                          ),
                        ),

                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        const Row(
                          children: [
                            Expanded(
                              child: CategoryType(),
                            ),
                            SizedBox(width: TSizes.spaceBtwInputFields),
                            Expanded(
                              child: StatusMenu(),
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.price,
                          validator: (value) => TValidator.validatePrice(value),
                          expands: false,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.dollar_circle),
                            labelText: 'Indiquer le prix en DH',
                          ),
                        ),

                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => controller
                                .createProperty(controller.property.value),
                            child: const Text('Ajouter une nouveau bien'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
