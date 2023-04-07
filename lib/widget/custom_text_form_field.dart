import 'package:education_app/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  bool isPassword;
  TextInputType? type;
  dynamic validate;
  dynamic onTap;
  dynamic onChange;
  dynamic onSuffixPressed;
  var controller;
  IconData? suffixIcon;
  String? lableText;
  String? hintText;
  Color? prefixIconColor;
  bool? isEnable;
  bool? isInDialog;
  List<TextInputFormatter>? limits;
  int? maxLines;
  TextAlign? textAlign;
  double? textSize;

  CustomTextFormField({
    this.isPassword = false,
    this.type = TextInputType.text,
    this.validate,
    this.onChange,
    this.limits,
    this.isInDialog = false,
    this.textSize,
    this.textAlign,
    this.onTap,
    this.maxLines = 1,
    this.suffixIcon,
    this.onSuffixPressed,
    this.controller,
    this.isEnable = true,
    this.lableText,
    this.prefixIconColor,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: textSize ?? 16,
        fontFamily: "Cairo",
      ),
      inputFormatters: limits,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      enabled: isEnable,
      maxLines: maxLines,
      validator: validate,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: AppColors.darkPrimary,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        labelText: lableText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: "Cairo",
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: "Cairo",
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: AppColors.darkPrimary,
          ),
          onPressed: onSuffixPressed,
        ),
      ),
    );
  }
}
