import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/app_bar.dart';
import '../home/food_page_body.dart';

class FoodHomePage extends StatefulWidget {
  FoodHomePage({Key? key}) : super(key: key);

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppColors.mainWhite,
          margin: EdgeInsets.only(
            top: Dimentions.fromHeight(6),
          ),
          child: Column(
            children: [
              SingleChildScrollView(child: AppBarWidget()),
              Expanded(child: SingleChildScrollView(child: FoodPageBody())),
            ],
          )),
    );
  }
}
