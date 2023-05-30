import 'package:food_app/utils/constance.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseURL;
  late String token = AppConstance.TOKEN;
  late Map<String, String>? _mainHeader;

  ApiClient({required this.appBaseURL}) {
    baseUrl = appBaseURL;
    timeout = Duration(seconds: 60);
    _mainHeader = {
      'Conect-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "Connection": "Keep-Alive",
    };
  }

  updateHeader(String token) {
    _mainHeader = {
      'Conect-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "Connection": "Keep-Alive",
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri, headers: _mainHeader);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeader);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
