import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/models/student_model.dart';
import 'package:education_app/shared/app_colors.dart';
import 'package:education_app/shared/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../models/attend_model.dart';

class AttendItem extends StatelessWidget {

  final AttendModel atendModel;
  final MainCubit cubit;

  const AttendItem({Key? key, required this.atendModel, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (dir){
          //cubit.deleteStudent(id: studentModel.id??1);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "إسم الطالـــب :",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      "${atendModel.userId}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "البريــــــــــــــد :",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    "Diaa",
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Cairo",
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 90,
                    child: Text(
                      "المرحلة التعليمية :",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      "dsakldsa",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                    children:  [
                      const Text("الحضــــــور",style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                      SizedBox(width: 40),
                      Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.check,color: Colors.green)),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

 Color setUpColor(String? level) {
    if(level==AppString.first){
      return AppColors.first;
    }else if(level==AppString.second){
      return AppColors.second;
    }else if(level==AppString.third){
      return AppColors.third;
    }
    else if(level==AppString.forth){
      return AppColors.forth;
    }
    else if(level==AppString.fifth){
      return AppColors.fifth;
    }
    else if(level==AppString.sixth){
      return AppColors.sixth;
    }else{
      return Colors.white;
    }
 }
}
