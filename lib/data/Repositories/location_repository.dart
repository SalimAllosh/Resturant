import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/user_address_model.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class LocatinRepository {
  final ApiClient apiClient;

  LocatinRepository({required this.apiClient});

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstance.geocodeURI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  saveLocation(Map<String, AddressModel> addressMap) {
    UserSharedPrefrences.saveUserAddress(addressMap);
  }

  userAddressModel? getSavesAddress() {
    return UserSharedPrefrences.getUserAddress();
  }

  Future<Response> saveLocationToServer(AddressModel address) async {
    return await apiClient.postData(
        AppConstance.postAddressURI, address.toJson());
  }
}
