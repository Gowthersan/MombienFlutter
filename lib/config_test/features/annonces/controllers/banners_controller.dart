import 'package:get/get.dart';
import 'package:mombien_test/config_test/data/repositories/banners/banners_repository.dart';
import 'package:mombien_test/config_test/features/annonces/models/banner_model.dart';
import 'package:mombien_test/config_test/utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  /// Fetch Banners
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      //Lire les bannières
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //Assigner les bannières
      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Une erreur de bannière s\'est produite.',
          message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
