import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_helper_controller.dart';
import 'package:food_app/controllers/recommended_meal_controller.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:food_app/pages/shoppingCart/shopping_cart_page.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/extandable_text.dart';
import 'package:food_app/widget/icon_in_circle.dart';
import 'package:food_app/widget/text_in_circle.dart';
import 'package:get/get.dart';

class RecommendedMealDetailPage extends StatefulWidget {
  final int mealID;
  final String from;

  RecommendedMealDetailPage(
      {Key? key, required this.mealID, required this.from})
      : super(key: key);

  @override
  State<RecommendedMealDetailPage> createState() =>
      _RecommendedMealDetailPageState();
}

class _RecommendedMealDetailPageState extends State<RecommendedMealDetailPage> {
  @override
  Widget build(BuildContext context) {
    MealModel meal = Get.find<RecommendedMealsController>()
        .recommendedMealsList[widget.mealID];
    Get.find<ShoppingCartHelperController>()
        .init(meal.id!, Get.find<ShoppingCartControll>(), meal.price!);
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: CustomScrollView(
        slivers: <Widget>[
          GetBuilder<ShoppingCartHelperController>(
              builder: (shoppingCartHelperController) {
            return SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              //collapsedHeight: 20,
              //show image
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstance.baseURI + AppConstance.imageSrc + meal.img!,
                  fit: BoxFit.cover,
                ),
              ),
              //meal name container
              bottom: PreferredSize(
                  child: Container(
                    height: Dimentions.fromHeight(4.5),
                    width: double.maxFinite,
                    child: Center(
                        child: BigText(
                      text: meal.name!,
                      color: AppColors.mainGray,
                    )),
                    decoration: BoxDecoration(
                      color: AppColors.mainWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimentions.bigRadius),
                          topRight: Radius.circular(Dimentions.bigRadius)),
                    ),
                  ),
                  preferredSize: Size.fromHeight(Dimentions.fromHeight(2))),
              expandedHeight: Dimentions.fromHeight(30),
              backgroundColor: AppColors.mainWhite,
              //go back
              leading: GestureDetector(
                onTap: () {
                  if (widget.from == "cart") {
                    Get.toNamed(AppRouts.getShoppingCartPage());
                  } else {
                    Get.toNamed(AppRouts.getInitial());
                  }
                },
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: Dimentions.squaresPercent(0.5),
                  color: AppColors.mainGray,
                ),
              ),
              //Shopping Cart Icon
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      // Get.to(ShoppingCartPage());
                      Get.toNamed(AppRouts.getShoppingCartPage());
                    },
                    child: Stack(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: Dimentions.squaresPercent(0.4),
                          color: AppColors.mainGray,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: TextInCircle(
                              text: shoppingCartHelperController
                                  .totalMealQuantity
                                  .toString()),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          //meal description
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: ExtandableText(text: meal.description!),
          )),
        ],
      ),
      //bottom navigation bar
      bottomNavigationBar: GetBuilder<ShoppingCartHelperController>(
          builder: (cartHelperController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //add and remove icons
            Container(
                color: AppColors.mainWhite,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: Dimentions.fromWidth(5),
                      bottom: Dimentions.fromHeight(0.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: cartHelperController.existedInShoppingCart
                            ? GestureDetector(
                                onTap: () {
                                  cartHelperController
                                      .deleteMealFromShoppingCart(meal.id!);
                                  setState(() {});
                                },
                                child: IconInCircle(
                                    icone: Icons.delete,
                                    iconColor: AppColors.mainGray,
                                    circleColor: AppColors.alert,
                                    iconeSize: Dimentions.squaresPercent(0.2)),
                              )
                            : Container(
                                width: Dimentions.squaresPercent(0.2),
                              ),
                      ),
                      Container(
                        width: Dimentions.fromWidth(80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartHelperController.addMeal(false);
                                cartHelperController.updatePrice();
                              },
                              child: IconInCircle(
                                  icone: Icons.remove,
                                  iconColor: AppColors.mainGray,
                                  circleColor: AppColors.alert,
                                  iconeSize: Dimentions.squaresPercent(0.2)),
                            ),
                            BigText(
                              text:
                                  "\$${cartHelperController.mealPrice} X ${cartHelperController.quantity}",
                              color: AppColors.mainGray,
                            ),
                            GestureDetector(
                              onTap: () {
                                cartHelperController.addMeal(true);
                                //setState(() {});
                              },
                              child: IconInCircle(
                                  icone: Icons.add,
                                  iconColor: AppColors.mainGray,
                                  circleColor: AppColors.alert,
                                  iconeSize: Dimentions.squaresPercent(0.2)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            //add with favorit
            Container(
              padding: EdgeInsets.all(Dimentions.fromTheHight(1)),
              height: Dimentions.fromHeight(13),
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //add and remove items - 1 +
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          Dimentions.fromTheHight(3),
                          Dimentions.fromHeight(2),
                          Dimentions.fromTheHight(3),
                          Dimentions.fromHeight(2)),
                      decoration: BoxDecoration(
                          color: AppColors.mainGray,
                          borderRadius:
                              BorderRadius.circular(Dimentions.mediumRadius)),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.alert,
                      ),
                    ),
                    //add to cart
                    GestureDetector(
                      onTap: () {
                        cartHelperController.addMealToShoopingCart(meal);
                        //setState(() {});
                      },
                      child: Container(
                          padding: EdgeInsets.fromLTRB(
                              Dimentions.fromTheHight(1),
                              Dimentions.fromHeight(2),
                              Dimentions.fromTheHight(1),
                              Dimentions.fromHeight(2)),
                          decoration: BoxDecoration(
                              color: AppColors.mainGray,
                              borderRadius: BorderRadius.circular(
                                  Dimentions.mediumRadius)),
                          child: BigText(
                            text:
                                "\$${cartHelperController.totalPrice} | add to cart",
                            color: AppColors.alert,
                          )),
                    ),
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
