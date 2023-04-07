import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownDepartment extends StatelessWidget {
  MainCubit cubit;

  DropDownDepartment({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            icon: Image.asset(
              'assets/images/icon_drop.png',
              width: 30,
              height: 30,
            ),
            buttonPadding: EdgeInsetsDirectional.only(end: 20, start: 30),
            buttonDecoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            hint: const Text(
              "إختر الشعبة ",
              style: TextStyle(color: Colors.grey, fontFamily: "Cairo",),
            ),
            items: cubit.studentDepartments
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Center(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            value: cubit.department,
            onChanged: (value) {
              cubit.chooseStudentDepartment(level: value as String);
            },
            buttonHeight: 70,
            buttonWidth: double.infinity,
            itemHeight: 60,
          ),
        ));
  }
}
