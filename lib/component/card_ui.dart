import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'card_task.dart';
import 'header_text.dart';
import 'task_in_progress.dart';
import 'task_progress.dart';



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
