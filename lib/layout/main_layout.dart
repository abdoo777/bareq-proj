import 'dart:convert';
import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/screens/search_screen/search_screen.dart';
import 'package:education_app/widget/alert_dialog_builder.dart';
import 'package:education_app/widget/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../shared/app_colors.dart';

/*class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return DefaultTabController(
          length: cubit.studentLevels.length,
          child: Scaffold(
            body: BackgroundWidget(cubit.screens[cubit.currentIndex]),
            appBar: AppBar(
              actions: [
                cubit.currentIndex == 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                            onPressed: () => showAddDialog(context, cubit),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            )),
                      )
                    : SizedBox(),
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen())),
                    icon: Icon(Icons.search)),
              ],
              bottom: cubit.currentIndex == 1
                  ? TabBar(
                      isScrollable: true,
                      indicatorColor: AppColors.darkPrimary,
                      tabs: cubit.tabs,
                    )
                  : null,
              elevation: 0,
              centerTitle: true,
              backgroundColor: AppColors.darkPrimary,
              title: Text(cubit.titles[cubit.currentIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Cairo",
                    fontSize: 23,
                  )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {

                cubit.insertAttendToDataBase(userId: 1, name: "diaa", department: 'd');
                //await LocalAuthApi.authenticate();
              },
            ),
            bottomNavigationBar: CurvedNavigationBar(
              items: cubit.bottomNaviItems,
              onTap: (index) => cubit.changeBottomNav(index),
              index: cubit.currentIndex,
              backgroundColor: AppColors.background,
              color: AppColors.darkPrimary,
            ),
          ),
        );
      },
    );
  }

  Future<void> showAddDialog(context, MainCubit cubit) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialogBuilder(
          cubit: cubit,
        );
      },
    );
  }
}*/


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  bool listenerRunning = false;
  int userId =0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          body: BackgroundWidget(cubit.screens[cubit.currentIndex]),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen())),
                  icon: const Icon(Icons.search)),
            ],
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.darkPrimary,
            title: Text(cubit.titles[cubit.currentIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Cairo",
                  fontSize: 23,
                )),
          ),
          floatingActionButton:cubit.currentIndex == 0 ||cubit.currentIndex==1 ?  FloatingActionButton(
            onPressed: () async {
              switch(cubit.currentIndex){
                case 0:
                  showAddDialog(context, cubit);
                  break;
                case 1:
                  _listenForNFCEvents(cubit);
                  break;
              }
            },
            child: const Icon(Icons.add),
          ):null,
          bottomNavigationBar: CurvedNavigationBar(
            items: cubit.bottomNaviItems,
            onTap: (index) => cubit.changeBottomNav(index),
            index: cubit.currentIndex,
            backgroundColor: AppColors.background,
            color: AppColors.darkPrimary,
          ),
        );
      },
    );
  }


  void _alert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }


  Future<void> _listenForNFCEvents(MainCubit cubit) async {
    if (Platform.isAndroid && listenerRunning == false || Platform.isIOS) {
      if (Platform.isAndroid) {
        _alert(
          'NFC listener running in background now, approach tag(s)',
        );
        setState(() {
          listenerRunning = true;
        });
      }
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          bool success = false;
          final ndefTag = Ndef.from(tag);
          if (ndefTag != null) {
            if (ndefTag.cachedMessage != null) {
              var ndefMessage = ndefTag.cachedMessage!;
              if (ndefMessage.records.isNotEmpty &&
                  ndefMessage.records.first.typeNameFormat ==
                      NdefTypeNameFormat.nfcWellknown) {
                final wellKnownRecord = ndefMessage.records.first;

                if (wellKnownRecord.payload.first == 0x02) {
                  final languageCodeAndContentBytes =
                  wellKnownRecord.payload.skip(1).toList();
                  final languageCodeAndContentText =
                  utf8.decode(languageCodeAndContentBytes);
                  final payload = languageCodeAndContentText.substring(2);
                  final storedCounters = int.tryParse(payload);
                  if (storedCounters != null) {
                    success = true;
                    _alert('User Id restored from tag');
                    setState(() {
                      userId = storedCounters;
                      cubit.insertAttendToDataBase(userId: userId);
                    });
                  }
                }
              }
            }
          }
          if (success == false) {
            _alert(
              'Tag was not valid',
            );
          }
        },
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
      );
    }
  }

  

  Future<void> showAddDialog(context, MainCubit cubit) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialogBuilder(
          cubit: cubit,
        );
      },
    );
  }
}