import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_helper_controller.dart';
import 'package:food_app/controllers/recommended_meal_controller.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
import 'controllers/popular_meal_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartHelperController>(
        builder: (shoppingCartHelperController) {
      return GetBuilder<ShoppingCartControll>(builder: (shoppingCartControll) {
        return GetBuilder<PopularMealsController>(builder: (context) {
          return GetBuilder<RecommendedMealsController>(builder: (context) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: AppRouts.getSplashPage(),
              getPages: AppRouts.routes,
            );
          });
        });
      });
    });
  }
}
