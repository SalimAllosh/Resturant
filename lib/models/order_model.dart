import 'package:food_app/models/cart_model.dart';
import 'package:food_app/utils/shared_preferences.dart';

class Order {
  static int id = UserSharedPrefrences.getorderId;
  //int? currentID = 0;
  List<CartModel>? items;
  late int? totalPrice;
  late int? totalQuantity;
  String? date;
  Order(
      {required this.items,
      required this.totalQuantity,
      required this.totalPrice,
      required this.date}) {
    id = id + 1;
    //currentID = id;
    UserSharedPrefrences.setorderId(id);
  }

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    totalQuantity = json['totalQuantity'];
    date = json['date'];

    if (json['items'] != null) {
      items = <CartModel>[];
      json['items'].forEach((v) {
        items!.add(CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['totalPrice'] = totalPrice;
    data['totalQuantity'] = totalQuantity;
    data['date'] = date;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
