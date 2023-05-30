import 'package:flutter/material.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/app_text_form.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/small_text_without_overflow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressPage extends StatefulWidget {
  final GoogleMapController googleMapController;
  PickAddressPage({required this.googleMapController, Key? key})
      : super(key: key);

  @override
  State<PickAddressPage> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  late CameraPosition _initialCameraPosition;
  late LatLng _latLng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<LocationController>().getSavedAddress();
    if (Get.find<LocationController>().userAddress.home == null &&
        Get.find<LocationController>().userAddress.office == null &&
        Get.find<LocationController>().userAddress.other == null) {
      _latLng = LatLng(-34.6037, -58.3816);
      _initialCameraPosition = CameraPosition(target: _latLng, zoom: 15);
      // Position _p = Position();
      //_latLng = widget.googleMapController;

      //_initialCameraPosition = CameraPosition(target: target);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.alert,
          child: Stack(
            children: [
              //AppTextForm(textEditingController: textEditingController, lable: "", icon: icon, textInputType: textInputType)
              TextField(decoration: InputDecoration()),
              GoogleMap(initialCameraPosition: _initialCameraPosition),
              Center(child: Image.asset("assets/images/pin.png", scale: 15)),
              Positioned(
                bottom: Dimentions.fromHeight(15),
                left: Dimentions.fromWidth(3),
                child: Container(
                  height: Dimentions.fromHeight(7),
                  width: Dimentions.fromWidth(94),
                  decoration: BoxDecoration(
                    color: AppColors.alert.withAlpha(200),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Confirm",
                      color: AppColors.mainWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
