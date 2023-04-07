import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/shared/constant.dart';
import 'package:education_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportScreen extends StatelessWidget {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if(state is GetALlReportByDateState){
          if(MainCubit.get(context).attendModelByDateList.isNotEmpty){
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              context: context, builder: (context) => Container(
                margin: const EdgeInsets.all(40),
                child: CustomButton(press: ()=>_printScreen(),text: "Print Report")),);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Data")));
          }
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  text: "اختر التاريخ",
                  press: () async {
                    final response = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010, 1, 1),
                        lastDate: DateTime.now());
                    await MainCubit.get(context).getReport(date: formatDate(datetime: response));


                    // if (MainCubit.get(context).attendModelByDateList.isEmpty) {
                    // } else {
                    //   _printScreen();
                    // }
                  }),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: RepaintBoundary(
                  key: _printKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * .15,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: const Text(
                                  "رقم الهوية",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                )),
                            Expanded(
                              child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: const Text(
                                    "الإســـــــــم",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * .15,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: const Text(
                                  "الشعبة",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                )),
                            Container(
                                width: MediaQuery.of(context).size.width * .2,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: const Text(
                                  "الحضور ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                )),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .15,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1)),
                                    child: Text(
                                      "${MainCubit.get(context).attendModelByDateList[index].userId}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18),
                                    )),
                                Expanded(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1)),
                                      child: Text(
                                        "${MainCubit.get(context).attendModelByDateList[index].name}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .15,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1)),
                                    child: Text(
                                      "${MainCubit.get(context).attendModelByDateList[index].department}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    )),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1)),
                                    child: Text(
                                      "${MainCubit.get(context).attendModelByDateList[index].isAttend == 1 ? "حضر" : "لم يحضر"}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ],
                            ),
                            itemCount: MainCubit.get(context)
                                .attendModelByDateList
                                .length,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }
}
