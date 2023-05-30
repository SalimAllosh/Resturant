import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/constance.dart';
import 'package:get/get.dart';

class RecommendedMealsRepository extends GetxService {
  final ApiClient apiClient;
  RecommendedMealsRepository({required this.apiClient});

  Future<Response> getRecommendedMeals() async {
    //print("In RecommendedMealsRepository calling app client ");
    return await apiClient.getData(AppConstance.recommendedProductURI);
  }
}
