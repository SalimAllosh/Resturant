import 'package:flutter/material.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/widget/icon_and_text.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import '../models/order_model.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'package:get/get.dart';

class OrderHistoryListViewContainer extends StatelessWidget {
  final Order order;
  const OrderHistoryListViewContainer({
    required this.order,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimentions.fromHeight(1)),
      height: Dimentions.fromHeight(25),
      width: Dimentions.fromWidth(80),
      //color: AppColors.mainGray,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(Dimentions.mediumRadius)),
      child: Padding(
        padding: EdgeInsets.all(Dimentions.fromHeight(1)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                      text: DateFormat.yMMMEd()
                              .format(DateTime.parse(order.date!)) +
                          "  " +
                          DateFormat.jm().format(DateTime.parse(order.date!))),
                  GetBuilder<ShoppingCartControll>(
                      builder: (shoppingCartControll) {
                    return GestureDetector(
                      onTap: () {
                        print("reOrderTaped");
                        shoppingCartControll.reorder(order.items!);
                        Get.toNamed(AppRouts.getShoppingCartPage());
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(4)),
                          child: SmallText(text: " Reorder ")),
                    );
                  }),
                ],
              ),
              Divider(
                color: AppColors.mainGray,
                thickness: 2,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.items!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      Container(
                        height: Dimentions.fromHeight(15),
                        width: Dimentions.fromHeight(15),
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimentions.fromWidth(1)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimentions.smallRadius),
                            color: AppColors.mainWhite,
                            image: DecorationImage(
                                //opacity: 0.8,
                                image: NetworkImage(AppConstance.baseURI +
                                    AppConstance.imageSrc +
                                    order.items![index].img!),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                          left: Dimentions.fromWidth(3),
                          top: Dimentions.fromHeight(1),
                          child: Row(
                            children: [
                              Container(
                                width: Dimentions.fromWidth(20),
                                child: SmallText(
                                    color: AppColors.mainBlack,
                                    text: order.items![index].name!,
                                    textOverflow: TextOverflow.ellipsis),
                              ),
                              SmallText(
                                  text: "X ${order.items![index].quantity}"),
                            ],
                          )),
                    ]);
                  },
                ),
              ),
              Divider(
                thickness: 2,
                color: AppColors.mainGray,
              ),
              Container(
                height: Dimentions.fromHeight(3),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconAndText(
                          icon: Icons.production_quantity_limits,
                          iconColor: AppColors.secondary1,
                          iconSize: Dimentions.squaresPercent(0.15),
                          text: order.totalQuantity.toString()),
                      IconAndText(
                          icon: Icons.monetization_on_outlined,
                          iconColor: AppColors.secondary2,
                          iconSize: Dimentions.squaresPercent(0.15),
                          text: order.totalPrice.toString())
                    ]),
              )
            ]),
      ),
    );
  }
}
