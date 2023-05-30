import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/constance.dart';
import 'package:get/get.dart';

class PopularMealsRepository extends GetxService {
  final ApiClient apiClient;
  PopularMealsRepository({required this.apiClient});

  Future<Response> getPopularMeals() async {
    // print("In Repository calling app client ");
    return await apiClient.getData(AppConstance.popularProductURI);
  }
}
