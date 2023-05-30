import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';

class AppTextForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final String lable;
  final IconData icon;
  final TextInputType textInputType;
  bool enable;
  bool obscureText;

  AppTextForm(
      {Key? key,
      required this.textEditingController,
      required this.lable,
      required this.icon,
      required this.textInputType,
      this.enable = true,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Dimentions.fromHeight(),
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
        boxShadow: [
          BoxShadow(
              offset: Offset(1, 1),
              color: Colors.black38,
              blurRadius: 3,
              spreadRadius: 1)
        ],
      ),
      width: Dimentions.fromWidth(94),
      child: TextFormField(
        key: Key("form" + "$lable"),
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: true,
        validator: (value) {
          if (lable == "password") {
            return null;
          } else if (lable == "email") {
            if (GetUtils.isEmail(value!)) {
              return null;
            }
            return "not a valed email";
          } else if (lable == "name") {
            if (GetUtils.isUsername(value!)) {
              return null;
            }
            return "not a valed UserName";
          } else if (lable == "phone") {
            if (GetUtils.isPhoneNumber(value!)) {
              return null;
            }
            return "not a valed Phone Number";
          }
        },
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabled: enable,
            filled: true,
            fillColor: AppColors.mainWhite,
            labelText: lable,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
            ),
            // alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
                borderSide: BorderSide(color: Colors.white)),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(Dimentions.mediumRadius),
            )),
      ),
    );
  }
}
