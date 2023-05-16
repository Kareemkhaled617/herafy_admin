import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widget/side_bar_menu.dart';

class Users extends StatelessWidget {
  final DeviceScreenType deviceScreenType;

  const Users({Key? key, required this.deviceScreenType}) : super(key: key);

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
              child: FutureBuilder(
                future: getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List users = snapshot.data as List;
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
                                        "Users",
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
                                        users.length,
                                        (index) => Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          child: ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Text(
                                                users[index]['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            leading: users[index]['image'] ==
                                                    'null'
                                                ? const CircleAvatar(
                                                    child: Icon(Icons.person),
                                                  )
                                                : Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            users[index]
                                                                ['image']),
                                                      ),
                                                    ),
                                                  ),
                                            trailing: const Text(''),
                                            subtitle: Column(
                                              children: [
                                                Text(users[index]['email']),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(users[index]
                                                    ['national_id']),
                                              ],
                                            ),
                                          ),
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
                                    color: Theme.of(context).iconTheme.color),
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

  Future getUsers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("users").get();
    return qn.docs;
  }
}
