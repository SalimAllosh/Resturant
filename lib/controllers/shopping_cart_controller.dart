import 'package:food_app/data/Repositories/shopping_cart_repository.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartControll extends GetxController {
  final ShoppingCartRepository shoppingCartRepository;

  ShoppingCartControll({required this.shoppingCartRepository});

  late Map<int, CartModel> meals = {};

  late List<CartModel> savedItems = [];
  late List<Order> savedorders = [];

  int _totalQuantity = 0;
  int get totalQuantity => _totalQuantity;

  int _totalPrice = 0;
  int get totalprice => _totalPrice;

  void addMeals(MealModel meal, int quantity) {
    if (meals.containsKey(meal.id)) {
      meals.update(meal.id!, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            img: value.img,
            price: value.price,
            quantity: quantity,
            time: DateTime.now().toString(),
            isExiste: true);
      });
    } else {
      meals.putIfAbsent(meal.id!, () {
        return CartModel(
            id: meal.id,
            name: meal.name,
            img: meal.img,
            price: meal.price,
            quantity: quantity,
            time: DateTime.now().toString(),
            isExiste: true);
      });
    }

    updateTotalQuntity();
    updateTotalPrice();
    shoppingCartRepository.addToCart(getMealsInCarts());
  }

  void deleteMeal(int mealID) {
    if (meals.containsKey(mealID)) {
      meals.removeWhere((key, value) => key == mealID);
    }
    updateTotalPrice();
    updateTotalQuntity();
    shoppingCartRepository.addToCart(getMealsInCarts());
  }

  bool existeInShoppingCart(int mealID) {
    if (meals.containsKey(mealID)) {
      return true;
    } else {
      return false;
    }
  }

  int? getQuantityIfExiste(int mealID) {
    if (meals.containsKey(mealID)) {
      return meals[mealID]!.quantity;
    } else {
      return 0;
    }
  }

  List<CartModel> getMealsInCarts() {
    List<CartModel> mealList = [];
    print("add meal list");
    meals.forEach((key, value) {
      mealList.add(value);
    });
    return mealList;
  }

  void updateMealQuantity(int mealID, int quantity) {
    meals[mealID]?.quantity = quantity;
    updateTotalQuntity();
    updateTotalPrice();
    // update();
  }

  CartModel getMeal(int mealID) {
    return meals[mealID]!;
  }

  void updateTotalQuntity() {
    int quantity = 0;
    meals.forEach((key, value) {
      quantity += value.quantity!;
    });
    _totalQuantity = quantity;
    print("total quantity is : $_totalQuantity");
    update();
  }

  void updateTotalPrice() {
    int totalPrice = 0;
    int localPrice;
    meals.forEach((key, value) {
      localPrice = value.quantity! * value.price!;
      totalPrice += localPrice;
    });
    _totalPrice = totalPrice;
    update();
  }

  List<CartModel> getsavedItems() {
    print("get saved items");
    setCart = shoppingCartRepository.getCartList();
    return savedItems;
  }

  set setCart(List<CartModel> items) {
    savedItems = items;
    for (var i = 0; i < savedItems.length; i++) {
      meals.putIfAbsent(savedItems[i].id!, () => savedItems[i]);
    }
    updateTotalPrice();
    updateTotalQuntity();
    update();
  }

  void saveOrder() {
    print("in save order calling get saved items in same controller ");
    getsavedItems();
    print("in save order new order initialized in controller ");
    Order order = Order(
        items: savedItems,
        totalPrice: totalprice,
        totalQuantity: totalQuantity,
        date: DateTime.now().toString());
    print("in save order in controller calling repo.saveorder");
    shoppingCartRepository.saveOrder(order);
    getSavedOrders();
    clearSavedItems();
  }

  void getSavedOrders() {
    savedorders = shoppingCartRepository.getOrderList().reversed.toList();
    update();
  }

  void clearHistory() {
    savedorders = [];
    shoppingCartRepository.clearHistory();
    update();
  }

  void clearSavedItems() {
    meals = {};
    savedItems = [];
    _totalQuantity = 0;
    _totalPrice = 0;
    shoppingCartRepository.clearSavedItems();
    update();
  }

  void reorder(List<CartModel> items) {
    for (var i = 0; i < items.length; i++) {
      meals.putIfAbsent(items[i].id!, () => items[i]);
    }
    updateTotalQuntity();
    updateTotalPrice();
    shoppingCartRepository.addToCart(getMealsInCarts());
    update();
  }
}
