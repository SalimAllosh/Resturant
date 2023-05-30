import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widget/small_text.dart';

class TextInCircle extends StatelessWidget {
  final String text;
  double textSize;
  Color textColor;
  Color circleColor;
  TextInCircle(
      {Key? key,
      required this.text,
      this.textSize = 15,
      this.textColor = AppColors.mainGray,
      this.circleColor = AppColors.alert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: circleColor,
        radius: (textSize + textSize * 0.4) / 2,
        child: SmallText(text: text));
  }
}
