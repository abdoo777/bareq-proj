import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/models/attend_model.dart';
import 'package:education_app/screens/attend_screen/widget/attend_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendDesign extends StatelessWidget {
 List<AttendModel> list;

 AttendDesign(this.list);

 @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return AttendItem(cubit:MainCubit.get(context),atendModel: list[index],);
              },
              separatorBuilder: (context, index) =>
              const SizedBox(height: 10),
              itemCount: MainCubit
                  .get(context)
              .attendList
                  .length),
        );
      },
    );
  }
}
