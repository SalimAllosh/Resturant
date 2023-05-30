import 'package:food_app/data/Repositories/sign_up_repository.dart';
import 'package:food_app/models/responce_model.dart';
import 'package:food_app/models/signup_model.dart';
import 'package:get/get.dart';
//import 'package:get/state_manager.dart';

class SignUpController extends GetxController implements GetxService {
  final SignUpRepository signUpRepository;

  SignUpController({required this.signUpRepository});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<ResponseModel> makeNewAccount(SignUpModel newUser) async {
    _isLoaded = true;
    update();
    await Future.delayed(const Duration(seconds: 1));
    Response response = await signUpRepository.MakeNewAccount(newUser);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      signUpRepository.saveToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.body["errors"].toString());
    }
    _isLoaded = false;
    update();
    return responseModel;
  }
}
