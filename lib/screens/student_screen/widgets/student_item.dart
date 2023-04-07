import 'dart:convert';
import 'dart:io';

import 'package:education_app/layout/cubit/main_cubit.dart';
import 'package:education_app/models/student_model.dart';
import 'package:education_app/screens/update_screen/update_screen.dart';
import 'package:education_app/shared/app_colors.dart';
import 'package:education_app/shared/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';

class StudentItem extends StatefulWidget {
  final StudentModel studentModel;
  final MainCubit cubit;

  const StudentItem({Key? key, required this.studentModel, required this.cubit})
      : super(key: key);

  @override
  State<StudentItem> createState() => _StudentItemState();
}

class _StudentItemState extends State<StudentItem> {
  bool listenerRunning = false;
  bool writeCounterOnNextContact = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UpdateScreen(studentModel: widget.studentModel))),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (dir) {
                widget.cubit.deleteStudent(id: widget.studentModel.id ?? 1);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                  color: setUpColor(widget.studentModel.level),
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
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blue,
                      backgroundImage:
                          widget.studentModel.image == AppString.defaultValue
                              ? const AssetImage("assets/images/user.png")
                              : MemoryImage(widget.cubit.converStringtoImage(
                                      image: widget.studentModel.image ?? ""))
                                  as ImageProvider,
                    ),
                    const SizedBox(width: 10),
                    Column(
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
                            Text(
                              "${widget.studentModel.name}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
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
                              "${widget.studentModel.email}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
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
                            Text(
                              "${widget.studentModel.level}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 90,
                              child: Text(
                                "القســـــــــــم :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Cairo",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              "${widget.studentModel.deparment}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: writeCounterOnNextContact ? null : _writeNfcTag,
                          child: Text(writeCounterOnNextContact
                              ? 'Waiting for tag to write'
                              : 'Write to tag'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color setUpColor(String? level) {
    if (level == AppString.first) {
      return AppColors.first;
    } else if (level == AppString.second) {
      return AppColors.second;
    } else if (level == AppString.third) {
      return AppColors.third;
    } else if (level == AppString.forth) {
      return AppColors.forth;
    } else if (level == AppString.fifth) {
      return AppColors.fifth;
    } else if (level == AppString.sixth) {
      return AppColors.sixth;
    } else {
      return Colors.white;
    }
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

  Future<void> _listenForNFCEvents() async {
    int userId = widget.studentModel.id!;
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
            if (writeCounterOnNextContact) {
              setState(() {
                writeCounterOnNextContact = false;
              });
              final ndefRecord = NdefRecord.createText(userId.toString());
              final ndefMessage = NdefMessage([ndefRecord]);
              try {
                await ndefTag.write(ndefMessage);
                _alert('Student written to tag');
                success = true;
              } catch (e) {
                _alert("Writting failed, press 'Write to tag' again");
              }
            }
            else if (ndefTag.cachedMessage != null) {
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

  @override
  void dispose() {
    try {
      NfcManager.instance.stopSession();
    } catch (_) {
      //We dont care
    }
    super.dispose();
  }

  void _writeNfcTag() {
    setState(() {
      writeCounterOnNextContact = true;
    });
    if (Platform.isAndroid) {
      _alert('Approach phone with tag');
    }
    _listenForNFCEvents();
  }
}
