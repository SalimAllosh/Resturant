import 'package:food_app/utils/shared_preferences.dart';

class AppConstance {
  static const String appName = "meals";

  //-----URLs--------
  static const String baseURI = "http://10.0.2.2:8000";
  static const String popularProductURI = "/api/v1/products/popular";
  static const String recommendedProductURI = "/api/v1/products/recommended";
  static const String signUpURI = "/api/v1/auth/register";
  static const String signInURI = "/api/v1/auth/login";
  static const String userInfoURI = "/api/v1/customer/info";
  static const String geocodeURI = "/api/v1/config/geocode-api";
  static const String postAddressURI = "/api/v1/customer/address/add";

  static const String imageSrc = "/uploads/";

  //-------Token----------
  static String TOKEN = "";

  //--------User Info -------
  static const String userAddress = "user-address";

  Map<String, String> userInfo = UserSharedPrefrences.getUserData();
}
