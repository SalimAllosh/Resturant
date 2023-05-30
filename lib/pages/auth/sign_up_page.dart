import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/sign_up_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/signup_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:food_app/widget/app_text_form.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/loading_progress_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var socialMediaList = [
    "assets/images/ggg.png",
    "assets/images/facebook.png",
    "assets/images/ttt.png"
  ];
  @override
  Widget build(BuildContext context) {
    var _emailEditingController = TextEditingController();
    var _passwordEditingController = TextEditingController();
    var _phoneEditingController = TextEditingController();
    var _nameEditingController = TextEditingController();

    _regester() {
      var signUpController = Get.find<SignUpController>();
      String email = _emailEditingController.text.trim();
      String password = _passwordEditingController.text.trim();
      String phone = _phoneEditingController.text.trim();
      String name = _nameEditingController.text.trim();

      SignUpModel signUpModel = SignUpModel(
          email: email, password: password, name: name, phone: phone);
      //print("");
      signUpController.makeNewAccount(signUpModel).then((status) {
        if (status.isSuccess) {
          print("regestration success");
          UserModel user = UserModel(
              email: _emailEditingController.text,
              phone: _phoneEditingController.text,
              fName: _nameEditingController.text);

          Get.find<UserController>().saveUserdata(user);
          Get.toNamed(AppRouts.getInitial());
        } else {
          print(status.message);
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: GetBuilder<SignUpController>(builder: (SignUpController) {
        return Stack(children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(children: [
                SizedBox(
                  height: Dimentions.fromHeight(8),
                ),
                Center(
                  child: CircleAvatar(
                    radius: Dimentions.fromHeight(10),
                    backgroundColor: AppColors.mainWhite,
                    backgroundImage:
                        const AssetImage("assets/images/startlogo.jpg"),
                  ),
                ),
                AppTextForm(
                  textEditingController: _emailEditingController,
                  lable: "email",
                  textInputType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                ),
                SizedBox(
                  height: Dimentions.fromHeight(2),
                ),
                AppTextForm(
                  textEditingController: _passwordEditingController,
                  lable: "password",
                  textInputType: TextInputType.emailAddress,
                  icon: Icons.password,
                  obscureText: true,
                ),
                SizedBox(
                  height: Dimentions.fromHeight(2),
                ),
                AppTextForm(
                  textEditingController: _nameEditingController,
                  lable: "name",
                  textInputType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                ),
                SizedBox(
                  height: Dimentions.fromHeight(2),
                ),
                AppTextForm(
                  textEditingController: _phoneEditingController,
                  lable: "phone",
                  textInputType: TextInputType.number,
                  icon: Icons.phone,
                ),
                SizedBox(
                  height: Dimentions.fromHeight(2),
                ),
                Container(
                  width: Dimentions.fromWidth(60),
                  height: Dimentions.fromTheHight(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimentions.bigRadius * 2))),
                  child: GetBuilder<UserController>(builder: (userController) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(AppColors.alert),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimentions.bigRadius * 2),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _regester();
                      },
                      child:
                          BigText(text: "Sign up", color: AppColors.mainGray),
                    );
                  }),
                ),
                SizedBox(
                  height: Dimentions.fromHeight(2),
                ),
                RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(AppRouts.getSignInPage()),
                        text: " have an account already..?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.mainGray,
                            fontSize: Dimentions.textSmall,
                            fontFamily: GoogleFonts.sriracha().fontFamily))),
                SizedBox(height: Dimentions.fromHeight(2)),
                RichText(
                    text: TextSpan(
                        text: "Sign up with another account",
                        style: TextStyle(
                            color: AppColors.mainGray,
                            fontFamily: GoogleFonts.sriracha().fontFamily))),
                SizedBox(height: Dimentions.fromHeight(2)),
                Wrap(
                    children: List.generate(
                        3,
                        (index) => Container(
                              margin: EdgeInsets.all(Dimentions.fromWidth(3)),
                              height: Dimentions.squaresPercent(1),
                              width: Dimentions.squaresPercent(1),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(socialMediaList[index]),
                                      fit: BoxFit.fill)),
                            ))),
              ]),
            ),
          ),
          if (SignUpController.isLoaded) ...[
            Center(child: LoadingProgressWidget())
          ]
        ]);
      }),
    );
  }
}
