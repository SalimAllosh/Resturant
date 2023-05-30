import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';

class IconInCircle extends StatelessWidget {
  final IconData icone;
  final double iconeSize;
  //double circleRadius;
  Color iconColor;
  Color circleColor;
  IconInCircle(
      {Key? key,
      required this.icone,
      required this.iconeSize,
      this.iconColor = AppColors.mainWhite,
      //this.circleRadius = 20,
      this.circleColor = AppColors.mainGray})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: circleColor,
      radius: (iconeSize + iconeSize * 0.4) / 2,
      child: Icon(
        icone,
        size: iconeSize,
        color: iconColor,
      ),
    );
  }
}
