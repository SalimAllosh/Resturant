import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_helper_controller.dart';
import 'package:food_app/controllers/popular_meal_controller.dart';
import 'package:food_app/controllers/recommended_meal_controller.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/data/Repositories/cart_helper_repository.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/widget/icon_in_square.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'big_text.dart';

class ShoppingCartListContainer extends StatefulWidget {
  int mealID;
  ShoppingCartListContainer({
    Key? key,
    required this.mealID,
  }) : super(key: key);

  @override
  State<ShoppingCartListContainer> createState() =>
      _ShoppingCartListContainerState();
}

class _ShoppingCartListContainerState extends State<ShoppingCartListContainer> {
  @override
  Widget build(BuildContext context) {
    // print("container start : mealID = $mealID ");
    //print(Get.find<ShoppingCartControll>().getMeal(mealID).quantity);
    CartModel meal = Get.find<ShoppingCartControll>().getMeal(widget.mealID);

    return Container(
      margin: EdgeInsets.all(Dimentions.fromTheHight(1)),
      child: Row(children: [
        GestureDetector(
          onTap: () {
            var popularPossition = Get.find<PopularMealsController>()
                .isPartOflist(meal.id!, meal.name!);

            var recommendedPossition = Get.find<RecommendedMealsController>()
                .isPartOflist(meal.id!, meal.name!);

            if (popularPossition != -1) {
              Get.toNamed(AppRouts.getPopularDetails(popularPossition, "cart"));
            } else if (recommendedPossition != -1) {
              Get.toNamed(
                  AppRouts.getRecommendedDetails(recommendedPossition, "cart"));
            }
          },
          child: Container(
            width: Dimentions.squaresPercent(4.5),
            height: Dimentions.squaresPercent(4.5),
            decoration: BoxDecoration(
              //color: AppColors.mainGray,
              borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
              image: DecorationImage(
                  image: NetworkImage(
                      AppConstance.baseURI + AppConstance.imageSrc + meal.img!),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Container(
            width: Dimentions.fromWidth(66),
            padding: EdgeInsets.all(Dimentions.fromTheHight(1)),
            height: Dimentions.squaresPercent(3.5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(Dimentions.mediumRadius),
                    topRight: Radius.circular(Dimentions.mediumRadius))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: meal.name!,
                  color: AppColors.mainBlack,
                  size: Dimentions.textMedium,
                ),
                Row(
                  children: [
                    BigText(
                      text: "\$ " + meal.price.toString(),
                      color: AppColors.primary,
                      size: Dimentions.textMedium,
                    ),
                    SizedBox(
                      width: Dimentions.fromWidth(10),
                    ),
                    BigText(
                      text: "\$ " + (meal.price! * meal.quantity!).toString(),
                      color: AppColors.mainGray,
                      size: Dimentions.textMedium,
                    ),
                  ],
                ),
                GetBuilder<ShoppingCartControll>(builder: (cartcontroller) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimentions.fromWidth(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (meal.quantity! - 1 > 0) {
                              cartcontroller.updateMealQuantity(
                                  widget.mealID, meal.quantity! - 1);
                            } else if (meal.quantity! - 1 == 0) {
                              Get.snackbar("Delete", "Slide to delete ",
                                  isDismissible: true,
                                  colorText: AppColors.alert);
                            }
                          },
                          child: IconInSquare(
                              icon: Icons.remove,
                              iconColor: AppColors.mainGray,
                              iconeSize: Dimentions.squaresPercent(0.4),
                              squareSize: Dimentions.squaresPercent(0.4),
                              squareColor: AppColors.alert,
                              squareRadius: Dimentions.vSmallRadius),
                        ),
                        BigText(
                            text: meal.quantity.toString(),
                            color: AppColors.mainGray),
                        GestureDetector(
                          onTap: () {
                            cartcontroller.updateMealQuantity(
                                widget.mealID, meal.quantity! + 1);
                          },
                          child: IconInSquare(
                              icon: Icons.add,
                              iconColor: AppColors.mainGray,
                              iconeSize: Dimentions.squaresPercent(0.4),
                              squareSize: Dimentions.squaresPercent(0.4),
                              squareColor: AppColors.primaryLight,
                              squareRadius: Dimentions.vSmallRadius),
                        )
                      ],
                    ),
                  );
                })
              ],
            ))
      ]),
    );
  }
}
