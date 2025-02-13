import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mombien_test/core.dart';

class StatusDropdownController extends GetxController {
  // Liste des statuts
  final List<String> statuses = [
    'Location',
    'Vente',
  ];

  // Statut sélectionné
  RxString selectedStatus = ''.obs;

  // Initialiser la sélection
  void setInitialStatus() {
    if (statuses.isNotEmpty) {
      selectedStatus.value = statuses.first; // Première valeur par défaut
    }
  }

  // Mettre à jour le statut sélectionné
  void updateSelectedStatus(String? value) {
    if (value != null) {
      selectedStatus.value = value;
    }
  }
}

class StatusMenu extends StatelessWidget {
  const StatusMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    final controller = Get.put(StatusDropdownController());
    controller.setInitialStatus();

    return Obx(() {
      return DropdownMenu<String>(
        width: double.infinity,
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
        initialSelection: controller.selectedStatus.value,
        onSelected: (String? value) {
          controller.updateSelectedStatus(value);
        },
        dropdownMenuEntries:
            controller.statuses.map<DropdownMenuEntry<String>>((String status) {
          return DropdownMenuEntry<String>(
            value: status,
            label: status,
          );
        }).toList(),
      );
    });
  }
}
