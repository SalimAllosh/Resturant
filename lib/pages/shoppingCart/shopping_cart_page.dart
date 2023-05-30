import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_app/controllers/cart_helper_controller.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';

import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/icon_in_circle.dart';

import 'package:food_app/widget/shopping_carl_listview_container.dart';
import 'package:food_app/widget/text_in_circle.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    List<CartModel> mealList =
        Get.find<ShoppingCartControll>().getMealsInCarts();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: IconInCircle(
              icone: Icons.arrow_back,
              iconColor: AppColors.mainGray,
              circleColor: AppColors.mainWhite,
              iconeSize: Dimentions.squaresPercent(0.3)),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouts.getInitial());
            },
            child: IconInCircle(
                icone: Icons.home,
                iconColor: AppColors.mainGray,
                circleColor: AppColors.alert,
                iconeSize: Dimentions.squaresPercent(0.3)),
          ),
          SizedBox(
            width: Dimentions.fromWidth(10),
          ),
          GetBuilder<ShoppingCartControll>(builder: (shoppingCartHelper) {
            return Stack(alignment: Alignment.center, children: [
              IconInCircle(
                icone: Icons.shopping_cart_checkout_rounded,
                iconColor: AppColors.mainGray,
                circleColor: AppColors.alert,
                iconeSize: Dimentions.squaresPercent(0.3),
              ),
              if (shoppingCartHelper.totalQuantity > 0) ...[
                Positioned(
                  top: 0,
                  right: 0,
                  child: TextInCircle(
                      circleColor: AppColors.mainWhite,
                      text: shoppingCartHelper.totalQuantity.toString()),
                )
              ],
            ]);
          }),
          SizedBox(
            width: Dimentions.fromWidth(5),
          )
        ],
        backgroundColor: AppColors.mainWhite,
      ),
      body: GetBuilder<ShoppingCartControll>(builder: (cartController) {
        return Container(
          height: Dimentions.fromHeight(70),
          color: AppColors.mainWhite,
          child: ListView.builder(
            itemCount: mealList.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: UniqueKey(),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(
                      dismissThreshold: 0.1,
                      onDismissed: () {
                        cartController.deleteMeal(mealList[index].id!);
                        mealList.removeAt(index);
                      }),
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        cartController.deleteMeal(mealList[index].id!);
                        mealList.removeAt(index);
                      },
                      backgroundColor: AppColors.alert,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ShoppingCartListContainer(
                  mealID: mealList[index].id!,
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: Dimentions.fromWidth(5),
          right: Dimentions.fromWidth(5),
        ),
        height: Dimentions.fromHeight(15),
        decoration: BoxDecoration(
          //color: Colors.black26,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimentions.bigRadius),
            topRight: Radius.circular(Dimentions.bigRadius),
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: Dimentions.fromWidth(35),
              height: Dimentions.fromHeight(10),
              decoration: BoxDecoration(
                color: AppColors.mainWhite,
                borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
              ),
              child: GetBuilder<ShoppingCartControll>(
                  builder: (shoppingCartController) {
                return Center(
                    child: GestureDetector(
                  onTap: (() {
                    //print("calling shopping cart controller getSavedOrders");
                    shoppingCartController.getSavedOrders();
                  }),
                  child: BigText(
                    text: " \$ ${shoppingCartController.totalprice}",
                    color: AppColors.mainBlack,
                  ),
                ));
              }),
            ),
            GetBuilder<ShoppingCartControll>(builder: (shoppingCartControll) {
              return GetBuilder<ShoppingCartHelperController>(
                  builder: (shoppingCartHelperController) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      shoppingCartControll.saveOrder();
                    });

                    Get.toNamed(AppRouts.getAddressPage("cart"));
                  },
                  child: Container(
                    width: Dimentions.fromWidth(35),
                    height: Dimentions.fromHeight(10),
                    decoration: BoxDecoration(
                        color: AppColors.mainWhite,
                        borderRadius:
                            BorderRadius.circular(Dimentions.mediumRadius)),
                    child: Center(
                        child: BigText(
                      text: "Continue",
                      color: AppColors.mainBlack,
                    )),
                  ),
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}
