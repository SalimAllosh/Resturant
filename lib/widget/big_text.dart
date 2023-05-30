import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final String text;
  double size;
  TextOverflow textOverflow;
  final Color? color;
  BigText({
    Key? key,
    required this.text,
    this.textOverflow = TextOverflow.ellipsis,
    this.size = 20,
    this.color = AppColors.primary,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        overflow: textOverflow);

    return Text(
      text,
      style: GoogleFonts.domine(textStyle: style),
      //maxLines: 2,
    );
  }
}
