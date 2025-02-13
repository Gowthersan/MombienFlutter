// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mombien_test/config_test/features/annonces/controllers/favoris_controller.dart';

class TAddFavoris extends StatelessWidget {
  const TAddFavoris({super.key, required this.propertyId, this.size});

  final String propertyId;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(() {
      return TCircularFavorisButton(
        icon:
            controller.isFavorite(propertyId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(propertyId) ? Colors.red : Colors.black,
        size: size,
        onPressed: () => controller.toggleFavoriteProperty(propertyId),
      );
    });
  }
}

class TCircularFavorisButton extends StatelessWidget {
  const TCircularFavorisButton({
    super.key,
    this.size,
    required this.color,
    required this.icon,
    this.onPressed,
  });

  final double? size;
  final Color color;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
