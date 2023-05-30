import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  TextOverflow textOverflow;
  int lineNumbers;
  SmallText({
    Key? key,
    required this.text,
    this.size = 15,
    this.textOverflow = TextOverflow.ellipsis,
    this.lineNumbers = 1,
    this.color = AppColors.mainGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: color,
      letterSpacing: 0.5,
      fontSize: size,
      overflow: textOverflow,
    );
    return Text(text, style: GoogleFonts.sriracha(textStyle: style));
  }
}
