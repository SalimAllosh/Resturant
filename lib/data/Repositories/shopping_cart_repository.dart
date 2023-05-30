import 'dart:convert';

import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class ShoppingCartRepository {
  ShoppingCartRepository();

  void addToCart(List<CartModel> cartList) {
    print("in repo calling userPrefrencesAddToCart");
    UserSharedPrefrences.userPrefrencesAddToCart(cartList);
  }

  List<CartModel> getCartList() {
    print("in repo calling getCartList");
    return UserSharedPrefrences.getCartList();
  }

  void saveOrder(Order order) {
    print("in repo calling preference.saveorder");
    UserSharedPrefrences.saveOrder(order);
  }

  List<Order> getOrderList() {
    print("in repo calling getOrderList");
    return UserSharedPrefrences.getOrderList();
  }

  void clearHistory() {
    print("in repo calling clearHistory");
    UserSharedPrefrences.clearHistory();
  }

  void clearSavedItems() {
    print("in repo calling clearSavedItems");
    UserSharedPrefrences.clearSavedItems();
  }
}
