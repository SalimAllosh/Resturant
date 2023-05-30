import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/sign_in_model.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constance.dart';

class SignInRepository {
  // api client
  ApiClient apiClient;

  SignInRepository({required this.apiClient});
  // method

  logIn(SignInModel user) async {
    return await apiClient.postData(AppConstance.signInURI, user.toJson());
  }

  savetoken(String token) {
    print("save token in log in repo");
    apiClient.token = token;
    apiClient.updateHeader(token);
    UserSharedPrefrences.setToken(token);
    AppConstance.TOKEN = token;
  }
}
