// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sky_chatter/global_widgets/custom_button.dart';
import 'package:sky_chatter/global_widgets/input_field.dart';
import 'package:sky_chatter/main.dart';
import 'package:sky_chatter/services/models/absence.dart';
import 'package:sky_chatter/services/models/user_model.dart';
import 'package:table_calendar/table_calendar.dart';

TextEditingController studentNumberController = TextEditingController();
TextEditingController reasonController = TextEditingController();

class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  // Gets absences for today
  Future<List<Absence>> getAbsences() async {
    List<Absence> returnValue = [];
    await FirebaseFirestore.instance.collection("absences").get().then((value) {
      for (var element in value.docs) {
        Absence absence = Absence.fromJson(element.data());
        if (isSameDay(DateTime.now(), absence.date)) {
          returnValue.add(absence);
        }
      }
    });
    return returnValue;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<UserType> userType = ref.read(userProvider).getUserType();
    return FutureBuilder(
      future: userType,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == UserType.student) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    textAlign: TextAlign.center,
                    'Please ask your parent or guardian to mark yourself absent.'),
              ),
            );
          } else if (snapshot.data == UserType.parent) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Spacer(),
                    const Text(
                      "Please enter your child's student number below. Doing so will mark them absent for all day today. If you plan on dropping your child off later today, please sign them in at the office.",
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputField(
                        controller: studentNumberController,
                        keyboardType: TextInputType.text,
                        isObscured: false,
                        label: 'Student ID Number',
                        validator: (value) {
                          if (value?.length != 7) {
                            return 'ID Number must be 7 digits long';
                          } else if (int.tryParse(value!.trim()) == null) {
                            return 'ID Number must only contain numbers.';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputField(
                        controller: reasonController,
                        keyboardType: TextInputType.text,
                        isObscured: false,
                        label: 'Reason For Absence',
                        validator: (value) {
                          return '';
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomButton(
                      text: 'Submit',
                      color: Theme.of(context).colorScheme.primary,
                      function: () async {
                        if (studentNumberController.value.text.length == 7 &&
                            int.tryParse(studentNumberController.value.text
                                    .trim()) !=
                                null) {
                          String? response = await ref
                              .read(userProvider)
                              .getUser(int.parse(studentNumberController.text));
                          if (response == null) {
                            FirebaseFirestore.instance
                                .collection("absences")
                                .add(
                              {
                                "name":
                                    "${ref.read(userProvider).districtUser.firstName} ${ref.read(userProvider).districtUser.lastName}",
                                "reason": reasonController.text,
                                "date": Timestamp.now()
                              },
                            );
                          }
                        }
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: FutureBuilder(
                  future: getAbsences(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title:
                                    Text(snapshot.data!.elementAt(index).name),
                                subtitle: Text(
                                    "Reason: ${snapshot.data!.elementAt(index).reason}"),
                                trailing: Text(DateFormat("yMd").format(
                                    snapshot.data!.elementAt(index).date)),
                              ),
                              const Divider()
                            ],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
