import 'package:flutter/material.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/big_text.dart';

import '../utils/colors.dart';
import 'icon_and_text.dart';
import 'small_text.dart';

class ListViewContainer extends StatelessWidget {
  final String imageSrc;
  final String mealName;
  final String mealDetail;
  String type;
  double distance;
  int time;

  ListViewContainer(
      {Key? key,
      required this.imageSrc,
      required this.mealName,
      required this.mealDetail,
      this.type = "normal",
      this.distance = 10,
      this.time = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimentions.fromTheHight(1)),
      child: Row(children: [
        Container(
          width: Dimentions.squaresPercent(4.5),
          height: Dimentions.squaresPercent(4.5),
          decoration: BoxDecoration(
            //color: AppColors.mainGray,
            borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
            image: DecorationImage(
              image: NetworkImage(imageSrc),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
            width: Dimentions.listViewContainerRight,
            padding: EdgeInsets.all(Dimentions.fromTheHight(1)),
            height: Dimentions.squaresPercent(3.5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(Dimentions.mediumRadius),
                    topRight: Radius.circular(Dimentions.mediumRadius))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BigText(
                  text: mealName,
                  color: AppColors.mainBlack,
                  size: Dimentions.textMedium,
                ),
                SmallText(text: mealDetail),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndText(
                          scale: 0.9,
                          icon: Icons.circle_sharp,
                          iconColor: AppColors.secondary1,
                          iconSize: Dimentions.squaresPercent(0.15),
                          text: type),
                      IconAndText(
                          scale: 0.9,
                          icon: Icons.location_on,
                          iconColor: AppColors.secondary2,
                          iconSize: Dimentions.squaresPercent(0.15),
                          text: distance.toString() + " Km"),
                      IconAndText(
                          scale: 0.9,
                          icon: Icons.access_time_rounded,
                          iconColor: AppColors.alert,
                          iconSize: Dimentions.squaresPercent(0.15),
                          text: time.toString() + " min"),
                    ],
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
