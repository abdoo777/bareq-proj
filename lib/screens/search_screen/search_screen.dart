import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../student_screen/widgets/student_item.dart';

class SearchScreen extends StatelessWidget {
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextFormField(
                  controller: search,
                  onChange: (String? value) {
                    MainCubit.get(context)
                        .searchAllStudents(name: value as String);
                  },
                  hintText: "بحث ...",
                  suffixIcon: Icons.search,
                ),
              ),
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => StudentItem(
                        studentModel: MainCubit.get(context).searchList[index],
                        cubit: MainCubit.get(context),
                      ),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: MainCubit.get(context).searchList.length),
              ),
            ],
          )),
        );
      },
    );
  }
}
