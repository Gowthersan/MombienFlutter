import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mombien_test/config_test/features/personnalisation/controllers/property_controller.dart';

class ImagesPreview extends StatelessWidget {
  const ImagesPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertiesController());

    return Obx(
      () => Container(
        // height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: controller.selectedImages.isEmpty
              ? const Center(child: Text('Aucune image choisie'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    final image = controller.selectedImages[index];
                    return ListTile(
                      key: ValueKey(controller.selectedImages[index].path),
                      leading: Image.file(
                        File(image
                            .path), // Affiche l'image à partir de son chemin
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        image.name, // Affiche le nom de l'image
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red), // Icône de suppression
                        onPressed: () {
                          // Appeler la méthode de suppression
                          controller.deleteImage(index, () {
                            Get.back();
                          });
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
