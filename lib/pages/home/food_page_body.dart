import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_meal_controller.dart';
import 'package:food_app/controllers/recommended_meal_controller.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/constance.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/rated_meal_detail.dart';
import 'package:food_app/widget/popular_food_listview_container.dart';
import '../../widget/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  var _currentPageVlue = 0.0;
  final double _scaleFactor = 0.8;
  final double _hight = Dimentions.fromHeight(28);
  final TextStyle s = const TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber);
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageVlue = _pageController.page!;
        //print(_currentPageVlue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //top 5 popular
        GetBuilder<PopularMealsController>(
          builder: (popularMeals) {
            return popularMeals.isLoaded
                ? //if loaded
                Container(
                    color: AppColors.mainWhite,
                    height: Dimentions.fromHeight(35),
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: popularMeals.popularMealsList.length,
                        itemBuilder: (context, possition) {
                          return _buildItems(
                            possition,
                            popularMeals.popularMealsList[possition],
                          );
                        }),
                  )
                : //if not loaded
                Container(
                    height: Dimentions.fromHeight(28),
                    padding: EdgeInsets.all(Dimentions.fromHeight(1)),
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimentions.bigRadius),
                            color: index.isEven
                                ? AppColors.alert
                                : AppColors.primary,
                          ),
                          height: Dimentions.fromHeight(28),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainGray,
                            ),
                          ),
                        );
                      },
                    ));
          },
        ),
        //Dot ....
        GetBuilder<PopularMealsController>(builder: ((popularMeals) {
          return DotsIndicator(
            dotsCount: popularMeals.popularMealsList.length <= 0
                ? 1
                : popularMeals.popularMealsList.length,
            position: _currentPageVlue,
            decorator: DotsDecorator(
              activeColor: AppColors.primary,
              size: Size.square(Dimentions.squaresPercent(0.03)),
              activeSize: Size(Dimentions.squaresPercent(0.2),
                  Dimentions.squaresPercent(0.03)),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimentions.smallRadius)),
            ),
          );
        })),
        SizedBox(
          height: Dimentions.fromHeight(1),
        ),
        //Recommended text
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimentions.fromHeight(1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: "Recommended",
                size: Dimentions.textMedium,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: SmallText(
                  text: "...",
                  size: Dimentions.textSmall,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: SmallText(
                  text: "Food prepairing",
                  size: Dimentions.textSmall,
                ),
              ),
            ],
          ),
        ),
        //List View

        GetBuilder<RecommendedMealsController>(builder: (recommendedMeals) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedMeals.recommendedMealsList.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                        AppRouts.getRecommendedDetails(index, "recommended"));
                  },
                  child: ListViewContainer(
                      imageSrc: AppConstance.baseURI +
                          AppConstance.imageSrc +
                          recommendedMeals.recommendedMealsList[index].img,
                      mealName:
                          recommendedMeals.recommendedMealsList[index].name,
                      mealDetail: recommendedMeals
                          .recommendedMealsList[index].description,
                      type: "normal",
                      distance: 1.1,
                      time: 20),
                );
              }));
        }),
      ],
    );
  }

  _buildItems(int index, MealModel meal) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageVlue.floor()) {
      var _currentScale = 1 - (_currentPageVlue - index) * (1 - _scaleFactor);
      var _currentTransform = _hight * (1 - _currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currentScale, 1)
        ..setTranslationRaw(0, _currentTransform, 0);
    } else if (index == _currentPageVlue.floor() + 1) {
      var _currentScale =
          _scaleFactor + (_currentPageVlue - index + 1) * (1 - _scaleFactor);
      var _currentTransform = _hight * (1 - _currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currentScale, 1)
        ..setTranslationRaw(0, _currentTransform, 0);
    } else if (index == _currentPageVlue.floor() - 1) {
      var _currentScale = 1 - (_currentPageVlue - index) * (1 - _scaleFactor);
      var _currentTransform = _hight * (1 - _currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currentScale, 1)
        ..setTranslationRaw(0, _currentTransform, 0);
    } else {
      var _currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, _currentScale, 1)
        ..setTranslationRaw(0, _hight * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          //print("in food page move to food detail of index $index");
          Get.toNamed(AppRouts.getPopularDetails(index, "popular"));
        },
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(
                left: Dimentions.fromTheHight(1),
                right: Dimentions.fromTheHight(1)),
            height: Dimentions.fromHeight(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimentions.bigRadius),
              color: index.isEven ? AppColors.alert : AppColors.primary,
              image: DecorationImage(
                  image: NetworkImage(
                      AppConstance.baseURI + "/uploads/" + meal.img.toString()),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: Dimentions.fromHeight(1),
                  left: Dimentions.fromTheHight(5),
                  right: Dimentions.fromTheHight(5)),
              height: Dimentions.fromHeight(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
                  color: AppColors.mainWhite,
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.mainGray,
                        offset: Offset(0, 5),
                        blurRadius: 5),
                    BoxShadow(
                      color: AppColors.mainWhite,
                      offset: Offset(5, 0),
                    ),
                    BoxShadow(
                      color: AppColors.mainWhite,
                      offset: Offset(-5, 0),
                    )
                  ]),
              child: Container(
                  margin: EdgeInsets.fromLTRB(
                      Dimentions.fromTheHight(1),
                      Dimentions.fromHeight(1.5),
                      Dimentions.fromTheHight(1),
                      Dimentions.fromTheHight(1)),
                  child: RatedMealDetail(
                      nameColor: AppColors.primaryHeavy,
                      mealName: meal.name.toString(),
                      rate: 4.5,
                      numOfcomments: 2500,
                      type: "normal",
                      distance: 1.5,
                      time: 30)),
            ),
          )
        ]),
      ),
    );
  }
}
