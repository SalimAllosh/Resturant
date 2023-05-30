import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/user_address_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/pages/addressPage/pick_address_page.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:food_app/widget/app_text_form.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/icon_in_square.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:food_app/widget/small_text_without_overflow.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:text_scroll/text_scroll.dart';

class AddressPage extends StatefulWidget {
  final String from;
  AddressPage({required this.from, Key? key}) : super(key: key);
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  int _activeIndex = 0;

  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-34.6037, -58.3816), zoom: 15);

  late LatLng _initialPosition = LatLng(-34.6037, -58.3816);

  late userAddressModel userAddress;
  late UserModel user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("In init calling get saved location ");
    print("In init calling get saved location ");
    print("In init calling get saved location ");
    if (UserSharedPrefrences.getUserAddress() == null) {
      print("shared is null");
      Get.find<LocationController>().saveAddress(AddressModel(
          addressType: "",
          contactPersonNumber: "",
          address: "",
          latitude: "",
          longitude: ""));
    }
    print("UserSharedPrefrences.getUserData");
    user = UserSharedPrefrences.getUserData();
    print("end UserSharedPrefrences.getUserData");
    _contactPersonName.text = user.fName!;
    _contactPersonNumber.text = user.phone!;
    _addressTextController.text =
        Get.find<LocationController>().currentLocation;
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getaddressname() {
    //Case()
    switch (_activeIndex) {
      case 0:
        return "Home";
      case 1:
        return "Office";
      case 2:
        return "Other";
      default:
        return "Not Selected";
    }
  }

  String getSavedAddressValues() {
    String homeAddress = "Not Selected";
    String officeAddress = "Not Selected";
    String otherAddress = "Not Selected";
    userAddress = UserSharedPrefrences.getUserAddress()!;

    switch (_activeIndex) {
      case 0:
        if (userAddress.home != null) {
          homeAddress = userAddress.home!.address;
        }
        return homeAddress;
      case 1:
        if (userAddress.office != null) {
          officeAddress = userAddress.office!.address;
        }
        return officeAddress;
      case 2:
        if (userAddress.other != null) {
          otherAddress = userAddress.other!.address;
        }
        return officeAddress;
      default:
        return "NotSelectedAddress";
    }
  }

  TextEditingController setAddressControllerValue() {
    switch (_activeIndex) {
      case 0:
        _addressTextController.text = getSavedAddressValues();
        return _addressTextController;
      case 1:
        _addressTextController.text = getSavedAddressValues();
        return _addressTextController;
      case 2:
        _addressTextController.text = getSavedAddressValues();
        return _addressTextController;
      default:
        _addressTextController.text = getSavedAddressValues();
        return _addressTextController;
    }
  }

  AddressModel createAddressModel() {
    print("create address model ");
    switch (_activeIndex) {
      case 0:
        AddressModel _address = AddressModel(
            address: Get.find<LocationController>().currentLocation,
            addressType: "home",
            contactPersonNumber: _contactPersonNumber.text,
            contactPersonName: _contactPersonName.text,
            latitude: _cameraPosition.target.latitude.toString(),
            longitude: _cameraPosition.target.longitude.toString());
        return _address;
      case 1:
        AddressModel _address = AddressModel(
            address: Get.find<LocationController>().currentLocation,
            addressType: "office",
            contactPersonNumber: _contactPersonNumber.text,
            contactPersonName: _contactPersonName.text,
            latitude: _cameraPosition.target.latitude.toString(),
            longitude: _cameraPosition.target.longitude.toString());
        return _address;
      case 2:
        AddressModel _address = AddressModel(
            address: Get.find<LocationController>().currentLocation,
            addressType: "other",
            contactPersonNumber: _contactPersonNumber.text,
            contactPersonName: _contactPersonName.text,
            latitude: _cameraPosition.target.latitude.toString(),
            longitude: _cameraPosition.target.longitude.toString());
        return _address;
      default:
        AddressModel _address = AddressModel(
            address: Get.find<LocationController>().currentLocation,
            addressType: "home",
            contactPersonNumber: "00000",
            contactPersonName: "",
            latitude: 0,
            longitude: 0);
        return _address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainWhite,
        appBar: AppBar(
          backgroundColor: AppColors.primaryLight,
          title: Center(
            child: SmallText(
              text: "Address",
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: GetBuilder<LocationController>(builder: (locationController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: Dimentions.fromHeight(30),
                    width: Dimentions.fromWidth(100),
                    decoration: BoxDecoration(
                      color: AppColors.mainGray,
                    ),
                    child: Stack(children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 17,
                        ),
                        onTap: (_) {
                          Get.toNamed(AppRouts.getPickAddressPage(),
                              arguments: PickAddressPage(
                                  googleMapController:
                                      Get.find<LocationController>()
                                          .mapController));
                        },
                        zoomControlsEnabled: true,
                        trafficEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        onCameraIdle: () {
                          //update
                          locationController.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: (position) {
                          _cameraPosition = position;
                        },
                        onMapCreated: (GoogleMapController controller) {
                          locationController.setMapController(controller);
                        },
                      ),
                    ]),
                  ),
                ),
                SmallText(text: "location address for : " + getaddressname()),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimentions.fromWidth(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeIndex = 0;
                          });
                        },
                        child: IconInSquare(
                            icon: Icons.home,
                            iconColor: _activeIndex == 0
                                ? AppColors.alert
                                : AppColors.mainGray,
                            iconeSize: Dimentions.squaresPercent(0.4),
                            squareSize: Dimentions.squaresPercent(0.5),
                            squareColor: AppColors.lightGray,
                            squareRadius: Dimentions.smallRadius * 0.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeIndex = 1;
                          });
                        },
                        child: IconInSquare(
                            icon: Icons.local_post_office,
                            iconColor: _activeIndex == 1
                                ? AppColors.alert
                                : AppColors.mainGray,
                            iconeSize: Dimentions.squaresPercent(0.4),
                            squareSize: Dimentions.squaresPercent(0.5),
                            squareColor: AppColors.lightGray,
                            squareRadius: Dimentions.smallRadius * 0.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeIndex = 2;
                          });
                        },
                        child: IconInSquare(
                            icon: Icons.other_houses,
                            iconColor: _activeIndex == 2
                                ? AppColors.alert
                                : AppColors.mainGray,
                            iconeSize: Dimentions.squaresPercent(0.4),
                            squareSize: Dimentions.squaresPercent(0.5),
                            squareColor: AppColors.lightGray,
                            squareRadius: Dimentions.smallRadius * 0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimentions.fromHeight(1)),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimentions.fromWidth(2)),
                  child: Row(children: [
                    Container(
                      width: Dimentions.fromWidth(33),
                      child: SmallText2(text: "Current location : "),
                    ),
                    Container(
                      width: Dimentions.fromWidth(63),
                      child: SingleChildScrollView(
                        //scrollDirection: Axis.vertical,
                        child: Flexible(
                          child: TextScroll(
                            locationController.currentLocation,
                            velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
                SizedBox(height: Dimentions.fromHeight(2)),
                AppTextForm(
                    textEditingController: setAddressControllerValue(),
                    lable: getaddressname(),
                    icon: Icons.location_city,
                    enable: false,
                    textInputType: TextInputType.text),
                SizedBox(height: Dimentions.fromHeight(2)),
                AppTextForm(
                    textEditingController: _contactPersonName,
                    lable: "",
                    icon: Icons.person,
                    enable: false,
                    textInputType: TextInputType.text),
                SizedBox(height: Dimentions.fromHeight(2)),
                AppTextForm(
                    textEditingController: _contactPersonNumber,
                    lable: "",
                    icon: Icons.phone,
                    enable: false,
                    textInputType: TextInputType.text),
                SizedBox(height: Dimentions.fromHeight(2)),
                Container(
                  height: Dimentions.fromHeight(7),
                  width: Dimentions.fromWidth(94),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimentions.mediumRadius)),
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.from == "profile") {
                        {
                          print("from profile ");
                          setState(() {
                            print("making address");
                            AddressModel address = createAddressModel();
                            print("save it");
                            locationController.saveAddress(address);
                          });
                        }
                      }
                    },
                    child: widget.from == "profile"
                        ? BigText(
                            text: "Edit Address", color: AppColors.mainGray)
                        : BigText(
                            text: "Confirm Order", color: AppColors.mainGray),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimentions.bigRadius * 0.5))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(AppColors.alert)),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
