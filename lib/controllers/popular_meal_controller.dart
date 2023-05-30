import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/data/Repositories/popular_meal_repository.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:get/get.dart';

class PopularMealsController extends GetxController {
  final PopularMealsRepository popularMealsRepository;
  PopularMealsController({required this.popularMealsRepository});

  //late ShoppingCartControll cartControll;

  List<dynamic> _popularMealsList = [];
  List<dynamic> get popularMealsList => _popularMealsList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularMealList() async {
    Response response = await popularMealsRepository.getPopularMeals();
    print("response statuscode" + response.statusCode.toString());
    print("response statustext" + response.statusText.toString());
    if (response.statusCode == 200) {
      _popularMealsList = [];
      _popularMealsList.addAll(Meals.fromJson(response.body).mealsList);
      _isLoaded = true;
      update();
    }
  }

  int isPartOflist(int ID, String name) {
    print("Popular meal is part of condetion ");

    int index = -1;
    int loc = 0;
    _popularMealsList.forEach((element) {
      if (element.id == ID && element.name == name) {
        index = loc;
        print("found it in location $loc");
      }
      loc++;
    });
    print("Condetion Return : $index");

    return index;
  }
}
