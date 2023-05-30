import 'package:food_app/data/Repositories/recommended_meal_repository.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:get/get.dart';

class RecommendedMealsController extends GetxController {
  final RecommendedMealsRepository recommendedMealsRepository;
  RecommendedMealsController({required this.recommendedMealsRepository});

  List<dynamic> _recommendedMealsList = [];
  List<dynamic> get recommendedMealsList => _recommendedMealsList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedMealList() async {
    Response response = await recommendedMealsRepository.getRecommendedMeals();

    if (response.statusCode == 200) {
      _recommendedMealsList = [];

      _recommendedMealsList.addAll(Meals.fromJson(response.body).mealsList);
      _isLoaded = true;
      update();
    }
  }

  int isPartOflist(int ID, String name) {
    print("recommended meal is part of condetion ");

    int index = -1;
    int loc = 0;
    _recommendedMealsList.forEach((element) {
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
