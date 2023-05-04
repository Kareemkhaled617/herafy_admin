import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'card_task.dart';
import 'header_text.dart';
import 'task_in_progress.dart';
import 'task_progress.dart';

final taskInProgress = [
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
  CardTaskData(
    label: "Personal branding",
    jobDesk: "Marketing",
    dueDate: DateTime.now().add(const Duration(hours: 4)),
  ),
  CardTaskData(
    label: "UI UX",
    jobDesk: "Design",
    dueDate: DateTime.now().add(const Duration(days: 2)),
  ),
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  )
];
const dataTask = TaskProgressData(totalTask: 5, totalCompleted: 1);

Widget buildTaskContent({Function()? onPressedMenu}) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('allService')
          .where('isAccept', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data?.docs as List;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                // Row(
                //   children: [
                //     Expanded(
                //       child: TextFormField(
                //         decoration: const InputDecoration(
                //           prefixIcon: Icon(Icons.search),
                //           enabledBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(width: .1),
                //           ),
                //           hintText: "search..",
                //         ),
                //         textInputAction: TextInputAction.search,
                //         style: TextStyle(color: kFontColorPallets[1]),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: HeaderText(
                        DateTime.now().formatdMMMMY(),
                      ),
                    ),
                    const SizedBox(width: 20.0 / 2),
                    // const SizedBox(
                    //   width: 200,
                    //   child: TaskProgress(data: dataTask),
                    // ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TaskInProgress(data: data),
                const SizedBox(height: 20.0 * 2),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

Future getAllServices() async {
  var firestore = FirebaseFirestore.instance;
  QuerySnapshot qn = await firestore.collection("allService").get();
  return qn.docs;
}
