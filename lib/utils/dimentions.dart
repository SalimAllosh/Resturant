import 'package:get/get.dart';
import 'dart:math';

class Dimentions {
  //--------------Widgets--------------------
  static double screenHight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //-------------fix----------
  static double listViewContainerRight =
      screenWidth - squaresPercent(4.5) - fromTheHight(2);

  //-----------------Texts----------------------------
  static double textBig = screenHight / screenWidth * 20;
  static double textMedium = screenHight / screenWidth * 10;
  static double textSmall = screenHight / screenWidth * 7;

  //---------------percent----------------------------
  static double fromTheHight(double x) {
    return (screenHight * x) / 100;
  }

  static double fromHeight(double x) {
    return (screenHight * x) / 100;
  }

  static double fromWidth(double x) {
    return (screenWidth * x) / 100;
  }

  static double squaresPercent(double x) {
    double screenAria = screenHight * screenWidth;
    double presentOfScreen = (screenAria * x) / 100;
    int res = sqrt(presentOfScreen).floor();

    return res.toDouble();
  }

  //-------------Raduis--------------
  static double bigRadius = screenHight / 32;
  static double mediumRadius = screenHight / 55;
  static double smallRadius = screenHight / 70;
  static double vSmallRadius = screenHight / 80;
}
