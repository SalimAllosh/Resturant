//import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/constance.dart';
//import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_meal_controller.dart';
import '../../controllers/recommended_meal_controller.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../utils/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  bool isSignedUp = false;

  Future<void> _loadRecources() async {
    await UserSharedPrefrences.init();
    Get.find<ShoppingCartControll>().getsavedItems();
    Get.find<ShoppingCartControll>().getSavedOrders();
    if (UserSharedPrefrences.getToken().isNotEmpty) {
      isSignedUp = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRecources();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    Timer(Duration(seconds: 3), () {
      if (isSignedUp) {
        Get.offNamed(AppRouts.getInitial());
      } else {
        Get.offNamed(AppRouts.getSignUpPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Center(
              child: Container(
                width: Dimentions.fromWidth(80),
                height: Dimentions.fromWidth(80),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/startlogo.jpg"),
                  ),
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _animation,
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
