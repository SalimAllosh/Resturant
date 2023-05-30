import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/small_text.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: Dimentions.fromHeight(1),
          left: Dimentions.fromTheHight(1),
          right: Dimentions.fromTheHight(1)),
      color: AppColors.mainWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              BigText(
                text: "Argantina",
                color: AppColors.primary,
                size: Dimentions.textBig,
              ),
              Row(
                children: [
                  SmallText(
                    text: "Salim",
                    size: Dimentions.textSmall,
                    lineNumbers: 1,
                  ),
                  const Icon(Icons.arrow_drop_down_rounded)
                ],
              )
            ],
          ),
          Container(
            height: Dimentions.squaresPercent(0.8),
            width: Dimentions.squaresPercent(0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimentions.smallRadius),
              color: AppColors.primary,
            ),
            child: Icon(
              Icons.search,
              color: AppColors.mainWhite,
              size: Dimentions.fromTheHight(5),
            ),
          ),
        ],
      ),
    );
  }
}
