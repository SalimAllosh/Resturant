import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/routes/routes_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/utils/shared_preferences.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  //late Map<String, String?> userInfo = <String, String?>{};
  UserModel user = UserSharedPrefrences.getUserData();
  String Token = UserSharedPrefrences.getToken();
  //print(UserSharedPrefrences.getToken());
  String userAddress = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: Center(
            child: BigText(
          text: "Profile",
          color: AppColors.mainGray,
        )),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(
            Dimentions.fromWidth(1),
            Dimentions.fromHeight(2),
            Dimentions.fromWidth(1),
            Dimentions.fromWidth(1)),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                //child: ,
                radius: Dimentions.fromTheHight(10),
                backgroundImage: AssetImage("assets/images/profile.png"),
                backgroundColor: AppColors.lightGray,
              ),
            ),
            SizedBox(
              height: Dimentions.fromHeight(5),
            ),
            Expanded(
              child: ListView(children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User Name'),
                  subtitle: Text(user.fName!),
                  iconColor: AppColors.secondary1,
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(user.email!),
                  iconColor: AppColors.alert,
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(user.phone!),
                  iconColor: AppColors.secondary2,
                ),
                ListTile(
                  onTap: () => Get.toNamed(AppRouts.getAddressPage("profile")),
                  leading: Icon(Icons.location_pin),
                  title: Text('Address'),
                  subtitle: Text('name of street'),
                  iconColor: AppColors.primary,
                ),
                ListTile(
                  onTap: () {
                    UserSharedPrefrences.logOut();
                    //Get.offAll(() => AppRouts.getSignInPage());
                    Get.toNamed(AppRouts.getSplashPage());
                  },
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  subtitle: Text('logout'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
