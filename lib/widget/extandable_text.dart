import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimentions.dart';
import 'package:food_app/widget/small_text.dart';

import 'small_text_without_overflow.dart';

class ExtandableText extends StatefulWidget {
  final String text;
  ExtandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExtandableText> createState() => _ExtandableTextState();
}

class _ExtandableTextState extends State<ExtandableText> {
  late String firstPart;
  late String secoundPart;
  double acceptedHight = Dimentions.fromHeight(20) / 2;
  bool hide = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int textLength = widget.text.length;

    if (textLength <= acceptedHight) {
      firstPart = widget.text;
      secoundPart = "";
    } else {
      double Length = textLength / 2;
      firstPart = widget.text.substring(0, Length.toInt());
      secoundPart = widget.text.substring(Length.toInt() + 1, textLength);
      hide = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.mainBlack,
      child: Column(children: [
        secoundPart.isEmpty
            ? SmallText2(text: widget.text)
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hide == true
                        ? SmallText2(text: firstPart + "...")
                        : SmallText2(text: firstPart + secoundPart),
                    SizedBox(
                      height: Dimentions.fromHeight(1),
                    ),
                    InkWell(
                      child: hide == true
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SmallText2(
                                    text: "Show more...",
                                    color: AppColors.primaryHeavy),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.primaryHeavy,
                                )
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SmallText2(
                                    text: "Show less...",
                                    color: AppColors.primaryHeavy),
                                Icon(
                                  Icons.arrow_drop_up,
                                  color: AppColors.primaryHeavy,
                                )
                              ],
                            ),
                      onTap: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                    )
                  ],
                ),
              ),
      ]),
    );
  }
}
