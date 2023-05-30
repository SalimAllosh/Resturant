import 'dart:convert';

import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/user_address_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

class UserSharedPrefrences {
  static late SharedPreferences _preferences;

  static setorderId(int x) {
    _preferences.setInt("ID", x);
  }

  static int get getorderId {
    return _preferences.getInt("ID")!;
  }

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setInt("ID", 0);
  }

  static List<String> cart = [];
  static Future<void> userPrefrencesAddToCart(List<CartModel> cartList) async {
    cart = [];
    // ignore: avoid_function_literals_in_foreach_calls
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });

    await _preferences.setStringList("cart", cart);
  }

  static getCartList() {
    List<String> carts = [];
    if (_preferences.containsKey("cart")) {
      carts = _preferences.getStringList("cart")!;
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => {cartList.add(CartModel.fromJson(jsonDecode(element)))});
    cartList.forEach((element) => print(element.id));
    return cartList;
  }

  static saveOrder(Order order) {
    print("in shared get orders ");
    List<String> orderHistory = _preferences.getStringList("orders")!;
    print("start encode order to string ");
    orderHistory.add(jsonEncode(order));
    print("finish encode order to string ");
    _preferences.setStringList("orders", orderHistory);
    print(" save order to prefe ");
  }

  static getOrderList() {
    //Map<String, dynamic> e;
    Order x;
    List<Order> orders = [];
    List<String> ordersString = [];
    if (_preferences.containsKey("orders")) {
      ordersString = _preferences.getStringList("orders")!;
    }
    ordersString.forEach((element) {
      //print(jsonDecode(element).runtimeType);
      x = Order.fromJson(jsonDecode(element));
      orders.add(x);
    });

    return orders;
  }

  static clearHistory() {
    _preferences.setInt("ID", 0);
    _preferences.setStringList("orders", []);
  }

  static clearSavedItems() {
    _preferences.setStringList("cart", []);
  }

  static setToken(String token) {
    _preferences.setString("token", token);
  }

  static getToken() {
    if (_preferences.getString("token") != null) {
      print(_preferences.getString('token'));
      return _preferences.getString("token");
    } else
      return "";
  }

  static saveUserData(UserModel user) {
    _preferences.setString("user-info", jsonEncode(user));
  }

  static getUserData() {
    if (_preferences.getString("user-info")! != null) {
      UserModel user =
          UserModel.fromJson(jsonDecode(_preferences.getString("user-info")!));
      return user;
    }
  }

  static saveUserAddress(Map<String, AddressModel> addressMap) {
    print("in shared save data ");
    String data = jsonEncode(addressMap);
    print("string data is : " + data);

    _preferences.setString("address", data);
  }

  static userAddressModel? getUserAddress() {
    userAddressModel useraddress = userAddressModel();
    if (_preferences.getString("address") != "") {
      String data = _preferences.getString("address")!;
      useraddress = userAddressModel.fromJson(jsonDecode(data));
      return useraddress;
    }
    return null;
  }

  static logOut() {
    _preferences.setString("user-info", "");
    _preferences.setString("token", "");
    _preferences.setString("address", "");
    clearHistory();
    clearSavedItems();
  }
}
