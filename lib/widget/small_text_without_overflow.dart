import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallText2 extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  SmallText2({
    Key? key,
    required this.text,
    this.size = 15,
    this.color = AppColors.mainGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: color,
      letterSpacing: 0.5,
      fontSize: size,
    );
    return Text(
      text,
      style: GoogleFonts.sriracha(textStyle: style),
      textAlign: TextAlign.justify,
    );
  }
}
