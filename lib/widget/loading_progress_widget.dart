import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/small_text.dart';

class LoadingProgressWidget extends StatelessWidget {
  const LoadingProgressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimentions.fromHeight(25),
      width: Dimentions.fromWidth(90),
      decoration: BoxDecoration(
          color: AppColors.mainWhite.withOpacity(0.9),
          borderRadius: BorderRadius.circular(Dimentions.bigRadius),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(2, 2), blurRadius: 10),
            BoxShadow(
                color: Colors.black38, offset: Offset(-2, -2), blurRadius: 5)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmallText(text: "Progressing ..."),
          SizedBox(
            height: Dimentions.fromHeight(2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimentions.fromWidth(10)),
            child: LinearProgressIndicator(
              //semanticsLabel: "semetrics lable",
              backgroundColor: AppColors.mainWhite,
              color: AppColors.alert,
              minHeight: Dimentions.fromHeight(1),
              //semanticsValue: "salim ",
              //value: 0.1,
              // key: ,
            ),
          )
        ],
      ),
    );
  }
}
