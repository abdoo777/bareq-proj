import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/screens/student_screen/widgets/department_drop_down.dart';
import 'package:education_app/screens/student_screen/widgets/level_drop_down.dart';
import 'package:education_app/screens/student_screen/widgets/student_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FilterdStudentScreen extends StatelessWidget {
  const FilterdStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children:
                [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropDownLevel(cubit: MainCubit.get(context)),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropDownDepartment(cubit: MainCubit.get(context)),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return StudentItem(studentModel: MainCubit.get(context).filterdList[index], cubit: MainCubit.get(context),);
                        },
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                        itemCount: MainCubit.get(context).filterdList.length),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
