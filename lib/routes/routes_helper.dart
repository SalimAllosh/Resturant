import 'package:food_app/pages/addressPage/address_page.dart';
import 'package:food_app/pages/addressPage/pick_address_page.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/pages/auth/sign_up_page.dart';
import 'package:food_app/pages/popularMealDetail/popular_meal_detail_page.dart';
import 'package:food_app/pages/recommendedMealDetail/recommended_meal_details_page.dart';
import 'package:food_app/pages/shoppingCart/shopping_cart_page.dart';
import 'package:food_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/home/main_page.dart';

class AppRouts {
  static const String _splash = "/";
  static const String _home = "/home";
  static const String _signin = "/signin";
  static const String _signup = "/signup";
  static const String _address = "/address";
  static const String _pickAddress = "/address/:pick-address";
  static const String _popularDetails = "/popular-details";
  static const String _recommendedDetails = "/recommended-details";
  static const String _shoppingCart = "/shopping-cart";

  static String getSplashPage() => _splash;
  static String getSignInPage() => _signin;
  static String getSignUpPage() => _signup;
  static String getInitial() => _home;

  static String getPickAddressPage() => _pickAddress;

  static String getAddressPage(String from) => "$_address?from=$from";

  static String getPopularDetails(int pageID, String from) =>
      "$_popularDetails?pageID=$pageID&from=$from";
  static String getRecommendedDetails(int mealID, String from) =>
      "$_recommendedDetails?mealID=$mealID&from=$from";
  static String getShoppingCartPage() => _shoppingCart;

  static List<GetPage> routes = [
    GetPage(
        name: _signin, page: () => SignInPage(), transition: Transition.fadeIn),
    GetPage(
        name: _signup, page: () => SignUpPage(), transition: Transition.fadeIn),
    GetPage(name: _splash, page: () => SplashPage()),
    GetPage(name: _home, page: () => MainPage()),
    GetPage(
      name: _address,
      page: () {
        var from = Get.parameters["from"];
        return AddressPage(
          from: from.toString(),
        );
      },
    ),
    GetPage(
        name: _pickAddress,
        page: () {
          PickAddressPage _addressPage = Get.arguments;
          return _addressPage;
        }),
    GetPage(
        name: _popularDetails,
        page: () {
          var pageID = Get.parameters["pageID"];
          var from = Get.parameters["from"];
          // print("call Route for populardetailpage with pageId $pageID");
          return PopularMealDetailsPage(
              pageID: int.parse(pageID!), from: from.toString());
        }),
    GetPage(
        name: _recommendedDetails,
        page: () {
          int mealID = int.parse(Get.parameters["mealID"]!);
          var from = Get.parameters["from"];
          return RecommendedMealDetailPage(
              mealID: mealID, from: from.toString());
        }),
    GetPage(
      name: _shoppingCart,
      page: () => ShoppingCartPage(),
    )
  ];
}
