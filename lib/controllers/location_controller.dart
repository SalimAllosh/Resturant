import 'package:food_app/data/Repositories/location_repository.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/user_address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocatinRepository locatinRepository;

  LocationController({required this.locatinRepository});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  late Position _position;
  Position get position => _position;

  late Position _pickedPosition;
  Position get PickedPosition => _pickedPosition;

  Placemark _placemark = Placemark();
  Placemark _pickesPlaceMark = Placemark();

  List<String> _addressTypeList = ["home", "office", "other"];
  int _addressTypeIndex = 0;

  late Map<String, AddressModel> _addressMap = {};
  Map get addressMap => _addressMap;
  late userAddressModel userAddress;

  bool _updateAddressDate = true;
  bool _changeAddress = true;

  String _currentLocation = "";
  String get currentLocation => _currentLocation;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> updatePosition(
      CameraPosition cameraPosition, bool fromAddress) async {
    print("in update position");
    if (_updateAddressDate) {
      _isLoaded = true;
      update();
      try {
        if (fromAddress) {
          print("from address == true");
          _position = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.longitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);

          print("position updated to ");
          print(_position.latitude);
          print(_position.longitude);
        } else {
          print("from address == false");
          _pickedPosition = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.longitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          print("change address == true");
          String _address = await getAddressFromGeocode(LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude));
          _currentLocation = _address;
          update();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String address = "No location";

    Response response = await locatinRepository.getAddressFromGeocode(latLng);

    if (response.body["status"] == "ok") {
      address = response.body["results"][0]["formatted_address"].toString();
    } else {
      if (response.body['error_message']
          .toString()
          .contains("Billing on the Google Cloud")) {
        address =
            "${latLng.latitude.toString()} + ${latLng.latitude.toString()} billProblems";
      }
      _currentLocation = address;
      print("Error Getting Google API");
      print(address);
    }
    update();
    return address;
  }

  saveAddress(AddressModel address) async {
    String type = address.addressType;
    if (_addressMap.containsKey(type)) {
      print("Key in map");
      _addressMap.update(type, (value) {
        return AddressModel(
            addressType: address.addressType,
            contactPersonNumber: address.contactPersonNumber,
            address: address.address,
            latitude: address.latitude,
            longitude: address.longitude);
      });
    } else {
      _addressMap.putIfAbsent(type, () {
        return AddressModel(
            addressType: address.addressType,
            contactPersonNumber: address.contactPersonNumber,
            address: address.address,
            latitude: address.latitude,
            longitude: address.longitude);
      });
    }

    Response response = await locatinRepository.saveLocationToServer(address);

    if (response.statusCode == 200) {
      print("connection succsess");
      print(response.body.toString());
    } else {
      print("connection Failed");
      print(response.statusText);
      print(response.body.toString());
    }
    locatinRepository.saveLocation(_addressMap);
    update();
  }

  void getSavedAddress() {
    if (locatinRepository.getSavesAddress() != null) {
      userAddress = locatinRepository.getSavesAddress()!;
    } else {
      print("no hay saved address");
    }
  }
}
