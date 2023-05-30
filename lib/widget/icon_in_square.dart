import 'package:flutter/material.dart';

class IconInSquare extends StatelessWidget {
  final IconData icon;
  final double squareRadius;
  final double squareSize;
  final Color squareColor;
  final Color iconColor;
  final double iconeSize;

  IconInSquare(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.iconeSize,
      required this.squareSize,
      required this.squareColor,
      required this.squareRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: squareSize,
      height: squareSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(squareRadius),
          color: squareColor),
      child: Center(
          child: Icon(
        icon,
        size: iconeSize,
        color: iconColor,
      )),
    );
  }
}
