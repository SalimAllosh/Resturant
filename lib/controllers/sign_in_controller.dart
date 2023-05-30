import 'package:food_app/data/Repositories/sign_in_repository.dart';
import 'package:food_app/models/responce_model.dart';
import 'package:food_app/models/sign_in_model.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SignInController extends GetxController implements GetxService {
// repo
  SignInRepository signInRepository;
  bool _isLoaded = false;
  bool get isloaded => _isLoaded;

// constructor
  SignInController({required this.signInRepository});
//method

  Future<ResponseModel> signIn(SignInModel user) async {
    _isLoaded = true;
    update();

    Response response = await signInRepository.logIn(user);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("sign in success");

      responseModel = ResponseModel(true, response.body["token"]);
      // print("token is " + responseModel.message);

      signInRepository.savetoken(response.body["token"]);
      // return responseModel;
    } else {
      //responseModel = ResponseModel(false, response.body["errors"].toString());
      print("error in loading ");
    }

    _isLoaded = false;
    update();

    return responseModel;
  }
}
