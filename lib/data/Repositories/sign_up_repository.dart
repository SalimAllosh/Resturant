import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/signup_model.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/utils/shared_preferences.dart';

class SignUpRepository {
  final ApiClient apiClient;
  SignUpRepository({required this.apiClient});

  //call api client to post data ,

  MakeNewAccount(SignUpModel newUser) async {
    return await apiClient.postData(AppConstance.signUpURI, newUser.ToJson());
  }

  //save token to sharedpreference
  saveToken(String token) {
    // print("save token in repository called");
    apiClient.token = token;
    apiClient.updateHeader(token);
    UserSharedPrefrences.setToken(token);
    AppConstance.TOKEN = token;
  }
}
