import 'package:flutter/material.dart';
import 'package:food_app/widget/small_text.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class RatedMealDetail extends StatelessWidget {
  final String mealName;
  final double rate;
  final int numOfcomments;
  final String type;
  final double distance;
  final int time;
  Color nameColor;
  Color detailColor;
  double nameFontSize = 30;
  int textFlow = 1;
  TextOverflow textOverflow = TextOverflow.ellipsis;
  RatedMealDetail(
      {Key? key,
      required this.mealName,
      required this.rate,
      required this.numOfcomments,
      required this.type,
      required this.distance,
      required this.time,
      this.nameColor = AppColors.mainBlack,
      this.detailColor = AppColors.mainGray})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: mealName,
          size: nameFontSize,
          color: nameColor,
          textOverflow: textOverflow,
        ),
        SizedBox(
          height: Dimentions.fromHeight(1),
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        size: Dimentions.squaresPercent(0.12),
                        color: AppColors.mainGray,
                      )),
            ),
            SizedBox(width: Dimentions.fromTheHight(1)),
            SmallText(
              text: rate.toString(),
              size: Dimentions.textSmall,
              color: detailColor,
            ),
            SizedBox(width: Dimentions.fromTheHight(1)),
            SmallText(
              text: numOfcomments.toString(),
              size: Dimentions.textSmall * 0.8,
              color: detailColor,
            ),
            SizedBox(width: Dimentions.fromTheHight(0.5)),
            SmallText(
              text: "Comments",
              size: Dimentions.textSmall,
              color: detailColor,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle_sharp,
                iconColor: AppColors.secondary1,
                iconSize: Dimentions.squaresPercent(0.15),
                text: type),
            IconAndText(
                icon: Icons.location_on,
                iconColor: AppColors.secondary2,
                iconSize: Dimentions.squaresPercent(0.15),
                text: distance.toString() + " Km"),
            IconAndText(
                icon: Icons.access_time_rounded,
                iconColor: AppColors.alert,
                iconSize: Dimentions.squaresPercent(0.15),
                text: time.toString() + " min"),
          ],
        )
      ],
    );
  }
}
