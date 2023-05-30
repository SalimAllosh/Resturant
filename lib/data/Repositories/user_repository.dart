import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:get/get.dart';

class UserRepository {
  ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<Response> getUserInfo() async {
    print(" user repo caling api client ");
    return await apiClient.getData(AppConstance.userInfoURI);
  }

  saveUserData(UserModel user) {
    print("in repo saving data called");
    UserSharedPrefrences.saveUserData(user);
  }
}
