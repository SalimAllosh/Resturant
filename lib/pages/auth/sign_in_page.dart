import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/sign_in_controller.dart';
import 'package:food_app/models/responce_model.dart';
import 'package:food_app/models/sign_in_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:food_app/widget/app_text_form.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/loading_progress_widget.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/user_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneTextEditingController = TextEditingController();
    var passwordTextEditingController = TextEditingController();

    Future<bool> _signIn() async {
      bool success = false;

      var _signInController = Get.find<SignInController>();
      var _userController = Get.find<UserController>();
      String phone = phoneTextEditingController.text.trim();
      String password = passwordTextEditingController.text.trim();

      SignInModel user = SignInModel(phone: phone, password: password);

      ResponseModel response = await _signInController.signIn(user);

      if (response.isSuccess) {
        ResponseModel responseModel = await _userController.getUserInfo();
        print("respose is " + responseModel.message);
        success = true;
        return success;
      } else {
        print("login failed");
        if (response.message.contains("Unauthorized")) {
          Get.snackbar("Error", "Wrong username or Password");
        }
        success = false;
        print(response.message);
        return success;
      }
    }

    return GetBuilder<SignInController>(builder: (signInController) {
      return Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(Dimentions.fromWidth(2)),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimentions.fromHeight(8),
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: Dimentions.fromHeight(10),
                        backgroundImage:
                            const AssetImage("assets/images/startlogo.jpg"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BigText(
                        text: "Hello",
                        color: AppColors.mainGray,
                        size: Dimentions.squaresPercent(1),
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.fromTheHight(1),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BigText(
                        text: "Sign into your account",
                        color: AppColors.mainGray,
                        //size: Dimentions.squaresPercent(1),
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.fromHeight(2),
                    ),
                    AppTextForm(
                      textEditingController: phoneTextEditingController,
                      lable: "phone",
                      textInputType: TextInputType.number,
                      icon: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimentions.fromHeight(2),
                    ),
                    AppTextForm(
                      textEditingController: passwordTextEditingController,
                      lable: "password",
                      textInputType: TextInputType.name,
                      icon: Icons.password,
                    ),
                    SizedBox(
                      height: Dimentions.fromHeight(2),
                    ),
                    Container(
                      width: Dimentions.fromWidth(60),
                      height: Dimentions.fromTheHight(7),
                      child: ElevatedButton(
                        onPressed: () async {
                          bool x = await _signIn();
                          if (x) {
                            Get.toNamed(AppRouts.getInitial());
                          }
                        },
                        child: SmallText(text: "SignIn"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimentions.bigRadius))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.alert)),
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.fromHeight(4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(text: "Don't have an account.. ? "),
                        RichText(
                            text: TextSpan(
                                text: "Create",
                                style: TextStyle(
                                    color: AppColors.mainGray,
                                    fontSize: Dimentions.squaresPercent(0.1),
                                    fontFamily:
                                        GoogleFonts.sriracha().fontFamily,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (() => {
                                        Get.toNamed(AppRouts.getSignUpPage())
                                      }))),
                      ],
                    )
                  ],
                )),
          ),
          if (signInController.isloaded) ...[
            Center(child: LoadingProgressWidget())
          ]
        ]),
      );
    });
  }
}
