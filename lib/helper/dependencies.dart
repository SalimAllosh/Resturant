import 'package:food_app/controllers/cart_helper_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/popular_meal_controller.dart';
import 'package:food_app/controllers/recommended_meal_controller.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/controllers/sign_in_controller.dart';
import 'package:food_app/controllers/sign_up_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/data/Repositories/cart_helper_repository.dart';
import 'package:food_app/data/Repositories/location_repository.dart';
import 'package:food_app/data/Repositories/popular_meal_repository.dart';
import 'package:food_app/data/Repositories/shopping_cart_repository.dart';
import 'package:food_app/data/Repositories/sign_in_repository.dart';
import 'package:food_app/data/Repositories/sign_up_repository.dart';
import 'package:food_app/data/Repositories/user_repository.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/constance.dart';
import 'package:get/get.dart';

import '../data/Repositories/recommended_meal_repository.dart';

Future<void> init() async {
  //Api client
  Get.lazyPut(
    () => ApiClient(appBaseURL: AppConstance.baseURI),
  );
  //Repositories
  Get.lazyPut(() => SignUpRepository(apiClient: Get.find()));
  Get.lazyPut(() => SignInRepository(apiClient: Get.find()));
  Get.lazyPut(() => UserRepository(apiClient: Get.find()));
  Get.lazyPut(() => LocatinRepository(apiClient: Get.find()));
  Get.lazyPut(() => PopularMealsRepository(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedMealsRepository(apiClient: Get.find()));
  Get.lazyPut(() => ShoppingCartRepository());
  Get.lazyPut(() => CartHelperRepository());

  //Controllers
  Get.lazyPut(() => SignUpController(signUpRepository: Get.find()));
  Get.lazyPut(() => SignInController(signInRepository: Get.find()));
  Get.lazyPut(() => UserController(userRepository: Get.find()));
  Get.lazyPut(() => LocationController(locatinRepository: Get.find()));

  Get.lazyPut(() => PopularMealsController(popularMealsRepository: Get.find()));
  Get.lazyPut(
      () => RecommendedMealsController(recommendedMealsRepository: Get.find()));
  Get.lazyPut(
      () => ShoppingCartHelperController(cartHelperRepository: Get.find()));
  Get.lazyPut(() => ShoppingCartControll(shoppingCartRepository: Get.find()));
}
