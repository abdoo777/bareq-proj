import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/models/student_model.dart';
import 'package:education_app/screens/student_screen/widgets/level_drop_down.dart';
import 'package:education_app/shared/app_strings.dart';
import 'package:education_app/widget/custom_button.dart';
import 'package:education_app/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatelessWidget {
  StudentModel studentModel;

  var studentName = TextEditingController();
  var department = TextEditingController();
  var level = TextEditingController();
  var email = TextEditingController();
  var address = TextEditingController();
  var formKey = GlobalKey<FormState>();

  UpdateScreen({required this.studentModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Center(
                          child: Text("تعديل طالب",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: "Cairo"))),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => cubit.chooseStudentImage(),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                  image: setUpImage(
                                      cubit: cubit,
                                      image: "${studentModel.image}"))),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: studentName..text = studentModel.name!,
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
                        controller: email..text = studentModel.email!,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "بريد الجامعة الإلكترونى مطلوب";
                          }
                        },
                        suffixIcon: Icons.email,
                        hintText: "بريد الجامعة الإلكترونى",
                      ),
                      const SizedBox(height: 10),
                      DropDownLevel(cubit: MainCubit.get(context)),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: department..text = studentModel.deparment!,
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
                          text: "تعديـــل",
                          press: () async {
                            if (formKey.currentState!.validate()) {
                              String? imageUrl = cubit.updatedStudentImage == null
                                  ? studentModel.image
                                  : await cubit.converImage(image: cubit.updatedStudentImage!);

                              StudentModel stude = StudentModel(
                                  id: studentModel.id,
                                  name: studentName.text,
                                  deparment: department.text,
                                  email: email.text,
                                  level: level.text,
                                  image: imageUrl);

                              cubit.updateStudent(model: stude);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ImageProvider setUpImage({required MainCubit cubit, required String image}) {
    if (cubit.updatedStudentImage != null) {
      return FileImage(cubit.updatedStudentImage!);
    } else {
      if (image == AppString.defaultValue) {
        return AssetImage(
          "assets/images/user.png",
        );
      } else {
        return MemoryImage(
            cubit.converStringtoImage(image: studentModel.image!));
      }
    }
  }
}
