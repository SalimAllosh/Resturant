import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_meal_controller.dart';
import 'package:food_app/controllers/recommended_meal_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/responce_model.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/pages/auth/sign_up_page.dart';

import 'package:food_app/pages/historyPage/HistoryPage.dart';
import 'package:food_app/pages/home/home_page.dart';
import 'package:food_app/pages/profilePage/profile_page.dart';
import 'package:food_app/pages/shoppingCart/shopping_cart_page.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  void loadRecorces() async {
    await Get.find<RecommendedMealsController>().getRecommendedMealList();
    await Get.find<PopularMealsController>().getPopularMealList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRecorces();
    _currentIndex = 0;
    _pageController = PageController();
  }

  void despose() {
    _pageController.dispose();
  }

  void onTapClick(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  final List<Widget> _pages = [
    FoodHomePage(),
    ShoppingCartPage(),
    OrdersHistoryPage(),
    ProfilePage()
  ];

  List<BottomNavyBarItem> _navBarsItems() {
    return [
      BottomNavyBarItem(
        icon: Icon(CupertinoIcons.home),
        title: Text("Home"),
        textAlign: TextAlign.center,
        activeColor: AppColors.primaryHeavy,
        inactiveColor: AppColors.mainGray,
      ),
      BottomNavyBarItem(
          icon: Icon(CupertinoIcons.archivebox),
          title: Text("Archive"),
          textAlign: TextAlign.center,
          activeColor: AppColors.primaryHeavy,
          inactiveColor: AppColors.mainGray),
      BottomNavyBarItem(
          icon: Icon(CupertinoIcons.shopping_cart),
          title: Text("Cart"),
          textAlign: TextAlign.center,
          activeColor: AppColors.primaryHeavy,
          inactiveColor: AppColors.mainGray),
      BottomNavyBarItem(
          icon: Icon(CupertinoIcons.person),
          title: Text("me"),
          textAlign: TextAlign.center,
          activeColor: AppColors.primaryHeavy,
          inactiveColor: AppColors.mainGray),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: _pages),
      ),
      bottomNavigationBar: BottomNavyBar(
        items: _navBarsItems(),
        onItemSelected: (index) => onTapClick(index),
        selectedIndex: _currentIndex,
        //curve: Curves.easeIn,
        backgroundColor: AppColors.lightGray,
        itemCornerRadius: 10,
        showElevation: false,
      ),
    );
  }
}
