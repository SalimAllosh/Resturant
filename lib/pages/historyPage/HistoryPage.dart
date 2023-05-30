import 'package:flutter/material.dart';
import 'package:food_app/controllers/shopping_cart_controller.dart';

import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';

import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

import '../../widget/order_history_listview_comtainer.dart';

class OrdersHistoryPage extends StatefulWidget {
  const OrdersHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrdersHistoryPage> createState() => _OrdersHistoryPageState();
}

class _OrdersHistoryPageState extends State<OrdersHistoryPage>
    with TickerProviderStateMixin {
  // List<Order> orders = Get.find<ShoppingCartControll>().savedorders;
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartControll>(builder: (shoppingCartControll) {
      return shoppingCartControll.savedorders.length > 0
          ? Container(
              child: Scaffold(
                backgroundColor: AppColors.mainWhite,
                appBar: AppBar(
                    title: Center(child: BigText(text: "My Orders")),
                    backgroundColor: AppColors.mainWhite),
                body: Container(
                  margin: EdgeInsets.only(
                      top: Dimentions.fromHeight(2),
                      left: Dimentions.fromHeight(1.5),
                      right: Dimentions.fromHeight(1.5)),
                  child: ListView.builder(
                    itemCount: shoppingCartControll.savedorders.length,
                    itemBuilder: (context, index) {
                      return OrderHistoryListViewContainer(
                          order: shoppingCartControll.savedorders[index]);
                    },
                  ),
                ),
                bottomNavigationBar: GestureDetector(
                  onTap: () {
                    shoppingCartControll.clearHistory();
                    setState(() {});
                  },
                  child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 8),
                      height: Dimentions.fromHeight(5),
                      decoration: BoxDecoration(
                        color: AppColors.alert,
                        //border: ,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimentions.vSmallRadius),
                          topRight: Radius.circular(Dimentions.vSmallRadius),
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.delete),
                      )),
                ),
              ),
            )
          : Container(
              child: Scaffold(
                body: Center(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Dimentions.fromWidth(90),
                        width: Dimentions.fromWidth(90),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/empty-shopping.png"),
                                fit: BoxFit.fill)),
                      ),
                      BigText(
                        text: "There are no previous orders",
                        color: AppColors.mainGray,
                      )
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
