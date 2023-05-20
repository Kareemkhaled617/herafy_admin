import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../test.dart';
import '../widget/side_bar_menu.dart';

class CraftsMan extends StatelessWidget {
  final DeviceScreenType deviceScreenType;

  const CraftsMan({Key? key, required this.deviceScreenType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff131e29),
        drawer: const SideBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 640,
              width: 1180,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("craftsman")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List craftman = snapshot.data!.docs as List;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "CraftsMan",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {}),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        craftman.length,
                                            (index) =>
                                            MemberCard(
                                              member: craftman[index],
                                              deviceScreenType: deviceScreenType,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.feedback),
                              const SizedBox(width: 10),
                              Text(
                                "Herafy For All Services",
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .iconTheme
                                        .color),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }

  Future getCraftsMan() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("craftsman").get();
    return qn.docs;
  }
}
