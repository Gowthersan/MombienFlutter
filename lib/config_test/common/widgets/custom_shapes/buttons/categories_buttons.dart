import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mombien_test/config_test/features/annonces/screens/home/categories_page.dart';
import 'package:mombien_test/config_test/utils/constants/sizes.dart';

class TCategoriesButton extends StatelessWidget {
  // final TCategoriesModel categoryModel;

  const TCategoriesButton({
    super.key,
    // required this.categoryModel,
    required this.name,
    required this.icon,
  });

  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => TCategoriesPage(name: name),
        transition: Transition.rightToLeft,
      ),
      child: TContainerForm(name: name, icon: icon),
    );
  }
}

class TContainerForm extends StatelessWidget {
  const TContainerForm({
    super.key,
    required this.icon,
    required this.name,
    // required this.category,
  });

  // final TCategoriesModel categoryModel;
  // final CategoryModel category;
  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(TSizes.sm),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          Flexible(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(),
              child: Icon(
                icon,
                size: TSizes.iconMd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
