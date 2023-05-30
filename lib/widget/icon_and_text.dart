import 'package:flutter/material.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/small_text.dart';

class IconAndText extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  double scale;
  IconAndText(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.iconSize,
      required this.text,
      this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon,
            size: iconSize * scale,
            color: iconColor,
          ),
          SizedBox(
            width: Dimentions.fromTheHight(0.4),
          ),
          SmallText(
            text: text,
            size: Dimentions.textSmall * scale,
          )
        ],
      ),
    );
  }
}
