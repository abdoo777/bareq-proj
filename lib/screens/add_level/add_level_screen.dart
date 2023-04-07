import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/screens/add_level/widget/level_drop_down.dart';
import 'package:education_app/widget/custom_button.dart';
import 'package:education_app/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLevelAndDepartmentScreen extends StatelessWidget {
  var level = TextEditingController();
  var department = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit =MainCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("إضافة مرحلة تعليمية",
                  style: TextStyle(fontSize: 20, fontFamily: "Cairo")),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("مرحلة تعليمية جديدة ؟",style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                        )),
                        Checkbox(
                            value: cubit.isChecked,
                            onChanged: (bool? value) =>cubit.changeCheck()
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    cubit.isChecked ?
                    CustomTextFormField(
                      controller: level,
                      hintText: "المرحلة التعليمية",
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "المرحلة التعليمية مطلوبة";
                        }
                      },
                    ):
                    DropDownAddLevel(cubit: cubit),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: department,
                      hintText: "الشعبة",
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "الشعبة مطلوبة";
                        }
                      },
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomButton(text: "إضافة", press: () async {}),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
