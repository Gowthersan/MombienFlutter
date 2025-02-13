import 'package:get/get.dart';
import 'package:mombien_test/config_test/features/annonces/screens/favoris/favoritescreen.dart';
import 'package:mombien_test/config_test/features/annonces/screens/home/home.dart';
import 'package:mombien_test/config_test/features/annonces/screens/proprietes/propriete_page.dart';
import 'package:mombien_test/config_test/features/annonces/screens/proprietes/proprietes_reviews.dart';
import 'package:mombien_test/config_test/features/authentification/screens/login/login.dart';
import 'package:mombien_test/config_test/features/authentification/screens/onboarding/onboarding.dart';
import 'package:mombien_test/config_test/features/authentification/screens/password_config/forget_password.dart';
import 'package:mombien_test/config_test/features/authentification/screens/signup/signup.dart';
import 'package:mombien_test/config_test/features/authentification/screens/signup/verify_email.dart';
import 'package:mombien_test/config_test/features/personnalisation/screens/address/add_new_adress.dart';
import 'package:mombien_test/config_test/features/personnalisation/screens/address/adress.dart';
import 'package:mombien_test/config_test/features/personnalisation/screens/settings/settings.dart';
import 'package:mombien_test/routes/routes.dart';

class AppRoutes {
  static final pages = [
    // Routes principales
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.properties, page: () => const ProprieteScreen()),
    GetPage(name: TRoutes.favourites, page: () => const Favoritescreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),

    // Routes de produits
    GetPage(
        name: TRoutes.propertyReviews,
        page: () => const ProprietesReviewsScreen()),
    // GetPage(
    //     name: TRoutes.propertyDetail,
    //     page: () => const TDetailsProprietesPage(property: property,)),

    // Routes de commande et panier
    // GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    // GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    // GetPage(name: TRoutes.cart, page: () => const CartScreen()),

    // Routes utilisateur
    GetPage(name: TRoutes.userProfile, page: () => const UserAdressScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const AddNewAdressScreen()),

    // Routes d'authentification
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),

    // Route d'introduction (onboarding)
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),

    // Ajoutez d'autres routes ici au besoin
  ];
}
