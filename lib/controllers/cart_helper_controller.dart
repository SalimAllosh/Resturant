import 'package:flutter/material.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/data/Repositories/cart_helper_repository.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:get/get.dart';
import '../models/meal_model.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';

class ShoppingCartHelperController extends GetxController {
  final CartHelperRepository cartHelperRepository;
  ShoppingCartHelperController({required this.cartHelperRepository});

  late ShoppingCartControll cartControll;
  int _quantity = 0;
  int get quantity => _quantity;

  int _cart_quantity = 0;
  int get cartQuantity => _cart_quantity;

  bool _existedInShoppingCart = false;
  bool get existedInShoppingCart => _existedInShoppingCart;

  int get totalMealQuantity {
    return cartControll.totalQuantity;
  }

  int _localPrice = 0;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  int _mealPrice = 0;
  int get mealPrice => _mealPrice;

  List<CartModel> mealInCart = [];

  void addMeal(bool isIncrement) {
    // _price = 100;
    if (isIncrement) {
      _quantity = newQuantityCondition(_quantity + 1);
      updatePrice();
    } else {
      _quantity = newQuantityCondition(_quantity - 1);
      updatePrice();
    }
    update();
  }

// Conditions AND SnachBar
  int newQuantityCondition(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Meal Count",
        "You Can't Decrease More ...!",
        icon: Icon(
          Icons.error_outline_sharp,
          size: Dimentions.squaresPercent(0.4),
          color: AppColors.alert,
        ),
        backgroundColor: AppColors.mainGray,
        isDismissible: true,
        overlayBlur: 1,
        barBlur: 10,
        dismissDirection: DismissDirection.startToEnd,
        overlayColor: AppColors.mainWhite.withOpacity(0.2),
        margin: EdgeInsets.only(bottom: Dimentions.fromHeight(40)),
        colorText: AppColors.mainWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
      return 0;
    } else if (quantity > 20) {
      Get.snackbar(
        "Meal Count",
        "You Can't Increase More ...!",
        icon: Icon(
          Icons.error_outline_sharp,
          size: Dimentions.squaresPercent(0.4),
          color: AppColors.alert,
        ),
        backgroundColor: AppColors.mainGray,
        isDismissible: true,
        overlayBlur: 1,
        barBlur: 10,
        dismissDirection: DismissDirection.startToEnd,
        overlayColor: AppColors.mainWhite.withOpacity(0.2),
        margin: EdgeInsets.only(bottom: Dimentions.fromHeight(40)),
        colorText: AppColors.mainWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
      return 20;
    } else {
      return quantity;
    }
  }

// Initial Values
  void init(int mealID, ShoppingCartControll cart, int mealPrice) {
    _quantity = cart.getQuantityIfExiste(mealID)!;
    _existedInShoppingCart = cart.existeInShoppingCart(mealID);
    _cart_quantity = 0;
    cartControll = cart;
    _mealPrice = mealPrice;
    _localPrice = 0;
  }

  void addMealToShoopingCart(MealModel meal) {
    print(
        "add to cart prresd \n now quantity is $_quantity to meal ${meal.name}");
    if (_quantity > 0) {
      cartControll.addMeals(meal, _quantity);
      // _quantity = 0;
    }
    update();
  }

  void deleteMealFromShoppingCart(int meal) {
    cartControll.deleteMeal(meal);

    update();
  }

  void updatePrice() {
    if (_quantity >= 1) {
      _localPrice = _mealPrice * _quantity;
    }
    _totalPrice = cartControll.totalprice;
    update();
  }
}
