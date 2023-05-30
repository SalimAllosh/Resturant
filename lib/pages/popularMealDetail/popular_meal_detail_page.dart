import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_helper_controller.dart';
import 'package:food_app/controllers/popular_meal_controller.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/extandable_text.dart';
import 'package:food_app/widget/icon_in_circle.dart';
import 'package:food_app/widget/rated_meal_detail.dart';
import 'package:food_app/widget/text_in_circle.dart';
import 'package:get/get.dart';

class PopularMealDetailsPage extends StatefulWidget {
  final int pageID;
  final String from;

  const PopularMealDetailsPage(
      {Key? key, required this.pageID, required this.from})
      : super(key: key);

  @override
  State<PopularMealDetailsPage> createState() => _PopularMealDetailsPageState();
}

class _PopularMealDetailsPageState extends State<PopularMealDetailsPage> {
  @override
  Widget build(BuildContext context) {
    int pageID = widget.pageID;
    MealModel meal =
        Get.find<PopularMealsController>().popularMealsList[pageID];

    Get.find<ShoppingCartHelperController>()
        .init(meal.id!, Get.find<ShoppingCartControll>(), meal.price!);
    //print(meal.name);
    return Scaffold(
      body: Stack(
        children: [
          //image backgraund
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Dimentions.fromHeight(38),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(AppConstance.baseURI +
                            AppConstance.imageSrc +
                            meal.img.toString()),
                        fit: BoxFit.cover)),
              )),
          //back And Cart icon Row
          Positioned(
              top: Dimentions.fromHeight(6),
              left: Dimentions.fromTheHight(2),
              right: Dimentions.fromTheHight(2),
              child: GetBuilder<ShoppingCartHelperController>(
                  builder: (mealController) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.from == "cart") {
                          Get.toNamed(AppRouts.getShoppingCartPage());
                        } else {
                          Get.toNamed(AppRouts.getInitial());
                        }
                      },
                      child: IconInCircle(
                        icone: Icons.arrow_back_outlined,
                        iconeSize: Dimentions.squaresPercent(0.3),
                        iconColor: AppColors.mainGray,
                        circleColor: AppColors.mainWhite,
                      ),
                    ),
                    if (mealController.totalMealQuantity == 0) ...[
                      IconInCircle(
                        icone: Icons.shopping_cart_outlined,
                        iconeSize: Dimentions.squaresPercent(0.3),
                        iconColor: AppColors.mainGray,
                        circleColor: AppColors.mainWhite,
                      )
                    ] else ...[
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouts.getShoppingCartPage());
                        },
                        child: Stack(
                          children: [
                            IconInCircle(
                              icone: Icons.shopping_cart_outlined,
                              iconeSize: Dimentions.squaresPercent(0.3),
                              iconColor: AppColors.mainGray,
                              circleColor: AppColors.mainWhite,
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: TextInCircle(
                                    text: mealController.totalMealQuantity
                                        .toString()))
                          ],
                        ),
                      )
                    ]
                  ],
                );
              })),

          //body of page
          Positioned(
              left: 0,
              right: 0,
              top: Dimentions.fromHeight(36),
              bottom: 0,
              //rated Detailes

              child: Container(
                padding: EdgeInsets.only(
                    left: Dimentions.fromTheHight(2),
                    right: Dimentions.fromTheHight(2),
                    top: Dimentions.fromTheHight(2)),
                decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimentions.bigRadius),
                        topRight: Radius.circular(Dimentions.bigRadius))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //rated meal detail
                      RatedMealDetail(
                          mealName: meal.name!,
                          rate: meal.stars!.toDouble(),
                          numOfcomments: 321,
                          type: "normal",
                          distance: 10,
                          time: 20),
                      SizedBox(
                        height: Dimentions.fromHeight(1),
                      ),
                      //Introduce
                      BigText(
                        text: "Introduce",
                        color: AppColors.mainBlack,
                      ),
                      SizedBox(
                        height: Dimentions.fromHeight(1),
                      ),
                      //ExtandableText
                      Expanded(
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            child: ExtandableText(text: meal.description!)),
                      )
                    ]),
              ))
        ],
      ),
      //bottom navigation bar
      bottomNavigationBar:
          GetBuilder<ShoppingCartHelperController>(builder: (mealController) {
        return Container(
          padding: EdgeInsets.all(Dimentions.fromTheHight(1)),
          height: Dimentions.fromHeight(13),
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.bigRadius),
                  topRight: Radius.circular(Dimentions.bigRadius))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //add and remove items - 1 +
            Container(
              width: Dimentions.fromTheHight(20),
              padding: EdgeInsets.fromLTRB(
                  Dimentions.fromTheHight(1),
                  Dimentions.fromHeight(2),
                  Dimentions.fromTheHight(1),
                  Dimentions.fromHeight(2)),
              decoration: BoxDecoration(
                  color: AppColors.alert,
                  borderRadius: BorderRadius.circular(Dimentions.mediumRadius)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (mealController.existedInShoppingCart) ...[
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              mealController
                                  .deleteMealFromShoppingCart(meal.id!);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.delete_forever,
                              color: AppColors.mainGray,
                              //size: Dimentions.squaresPercent(0.8),
                            ),
                          ),
                          BigText(
                            text: " | ",
                            color: AppColors.mainGray,
                          )
                        ],
                      )
                    ],
                    GestureDetector(
                      onTap: () {
                        mealController.addMeal(false);
                      },
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.mainGray,
                      ),
                    ),
                    SizedBox(width: Dimentions.fromTheHight(1)),
                    BigText(
                      text: mealController.quantity.toString(),
                      color: AppColors.mainGray,
                    ),
                    SizedBox(width: Dimentions.fromTheHight(1)),
                    GestureDetector(
                      onTap: () {
                        mealController.addMeal(true);
                      },
                      child: const Icon(
                        Icons.add,
                        // size: Dimentions.squaresPercent(0.4),
                        color: AppColors.mainGray,
                      ),
                    )
                  ]),
            ),
            //add to cart

            Container(
                width: Dimentions.fromTheHight(22),
                padding: EdgeInsets.fromLTRB(
                    Dimentions.fromTheHight(1),
                    Dimentions.fromHeight(2),
                    Dimentions.fromTheHight(1),
                    Dimentions.fromHeight(2)),
                decoration: BoxDecoration(
                    color: mealController.quantity > 0
                        ? AppColors.secondary2
                        : Colors.black26,
                    borderRadius:
                        BorderRadius.circular(Dimentions.mediumRadius)),
                child: GestureDetector(
                    onTap: () {
                      mealController.addMealToShoopingCart(meal);
                      //setState(() {});
                    },
                    child: BigText(
                      text:
                          "${mealController.mealPrice.toString()} | add to cart",
                      color: AppColors.mainWhite,
                    )))
          ]),
        );
      }),
    );
  }
}
