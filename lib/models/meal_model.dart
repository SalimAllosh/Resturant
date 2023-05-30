class Meals {
  late List<MealModel> _mealsList;
  List<MealModel> get mealsList => _mealsList;

  Meals(
      {required totalSize,
      required typeId,
      required offset,
      required mealsList});

  Meals.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      _mealsList = <MealModel>[];
      json['products'].forEach((v) {
        _mealsList.add(MealModel.fromJson(v));
      });
    }
  }
}

class MealModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  MealModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  MealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }
}
