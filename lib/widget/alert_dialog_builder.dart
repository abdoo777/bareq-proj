import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:education_app/shared/app_strings.dart';
import 'package:education_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../layout/cubit/main_cubit.dart';
import 'custom_text_form_field.dart';

class AlertDialogBuilder extends StatefulWidget {
  MainCubit cubit;
  String? level;

  AlertDialogBuilder({required this.cubit});

  @override
  State<AlertDialogBuilder> createState() => _AlertDialogBuilderState();
}

class _AlertDialogBuilderState extends State<AlertDialogBuilder> {
  var studentName = TextEditingController();
  var department = TextEditingController();
  var level = TextEditingController();
  var email = TextEditingController();
  var address = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File? studentImage;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: ListBody(
              children: <Widget>[
                const SizedBox(height: 30),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)),
                  child: studentImage != null
                      ? InkWell(
                          onTap: () => chooseStudentImage(),
                          child: CircleAvatar(
                            backgroundImage: FileImage(studentImage!),
                          ),
                        )
                      : IconButton(
                          onPressed: () => chooseStudentImage(),
                          icon: Icon(Icons.camera_alt)),
                ),
                const SizedBox(height: 10),
                const Center(
                    child: Text("إضافة طالب",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontFamily: "Cairo"))),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: studentName,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "إسم الطالب مطلوب";
                    }
                  },
                  suffixIcon: Icons.person,
                  hintText: "إسم الطالب",
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: email,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "بريد الجامعة الإلكترونى مطلوب";
                    }
                  },
                  suffixIcon: Icons.email,
                  hintText: "بريد الجامعة الإلكترونى",
                ),
                const SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        icon: Image.asset(
                          'assets/images/icon_drop.png',
                          width: 30,
                          height: 30,
                        ),
                        buttonPadding:
                            EdgeInsetsDirectional.only(end: 20, start: 30),
                        buttonDecoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hint: const Text(
                          "إختر المرحلة التعليمية ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Cairo",
                          ),
                        ),
                        items: widget.cubit.studentLevels
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
                        value: widget.level,
                        onChanged: (value) {
                          widget.level = value as String;
                          setState(() {});
                        },
                        buttonHeight: 70,
                        buttonWidth: double.infinity,
                        itemHeight: 60,
                      ),
                    )),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: department,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "إسم القسم مطلوب";
                    }
                  },
                  suffixIcon: Icons.dashboard_rounded,
                  hintText: "إسم القسم",
                ),
                const SizedBox(height: 30),
                CustomButton(
                    text: "إضافة ",
                    press: () {
                      if (formKey.currentState!.validate()) {
                        if(widget.level !=null){
                            widget.cubit.insertStudentToDataBase(
                                name: studentName.text,
                                isWithImage: studentImage != null ? true : false,
                                image: studentImage,
                                level: widget.level ?? "",
                                email: email.text,
                                department: department.text).then((value) {
                                  Navigator.pop(context);
                            });
                        }else{
                          print("i");
                        }

                      }
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> chooseStudentImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        studentImage = File(image.path);
      });
    }
  }
}
