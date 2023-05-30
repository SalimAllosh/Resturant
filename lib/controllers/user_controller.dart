import 'package:food_app/data/Repositories/user_repository.dart';
import 'package:food_app/models/responce_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  UserRepository userRepository;

  UserController({required this.userRepository});
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<ResponseModel> getUserInfo() async {
    print("user controller calling userRepository.getUserInfo()");
    Response response = await userRepository.getUserInfo();
    ResponseModel responseModel;
    UserModel user;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body.toString());
      user = UserModel.fromJson(response.body);
      _isLoggedIn = true;
      userRepository.saveUserData(user);
    } else {
      responseModel = ResponseModel(false, response.statusCode.toString());
    }
    return responseModel;
  }

  void saveUserdata(UserModel user) {
    userRepository.saveUserData(user);
  }
}
