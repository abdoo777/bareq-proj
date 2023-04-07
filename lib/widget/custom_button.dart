import 'package:education_app/shared/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? text;
  final Function? press;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? weight;
  final Color? borderColor;

  CustomButton(
      {required this.text,
      required this.press,
      this.width,
      this.height,
      this.backgroundColor,
      this.textColor,
      this.weight,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? double.infinity,
        height: height ?? 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor == null ? AppColors.darkPrimary : borderColor!,
              width: 1,
            ),
            color: backgroundColor ?? AppColors.darkPrimary,
            borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
            onPressed: press as void Function(),
            child: Text(text!,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontFamily:"Cairo",
                  fontWeight: weight,
                  fontSize: 22,
                ))));
  }
}
