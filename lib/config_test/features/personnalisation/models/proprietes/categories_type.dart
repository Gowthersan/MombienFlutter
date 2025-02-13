import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mombien_test/config_test/features/annonces/controllers/category_controller.dart';
import 'package:mombien_test/config_test/features/annonces/models/category_model.dart';
import 'package:mombien_test/core.dart';

class CategoryType extends StatelessWidget {
  const CategoryType({super.key});
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CategoryController());
    controller.setInitialCategory();

    return Obx(() {
      return Theme(
        data: Theme.of(context).copyWith(
            popupMenuTheme: PopupMenuThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
          position: PopupMenuPosition.under,
        )),
        child: DropdownMenu<String>(
          // width: double.infinity,
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(
              darkMode ? TColors.black : TColors.white,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                side: BorderSide(
                  color: darkMode ? TColors.grey : TColors.dark,
                  width: 1,
                ),
              ),
            ),
          ),
          initialSelection: controller.selectedCategory.value,
          onSelected: (String? value) {
            controller.updateSelectedCategory(value);
          },
          dropdownMenuEntries: controller.allCategories
              .map<DropdownMenuEntry<String>>((CategoryModel category) {
            return DropdownMenuEntry<String>(
              value:
                  category.name, // assuming CategoryModel has a 'name' property
              label: category.name,
            );
          }).toList(),
        ),
      );
    });
  }
}
