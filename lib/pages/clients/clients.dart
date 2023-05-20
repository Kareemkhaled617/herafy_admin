import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widget/side_bar_menu.dart';

class Clients extends StatelessWidget {
  final DeviceScreenType deviceScreenType;

  const Clients({Key? key, required this.deviceScreenType}) : super(key: key);

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
                stream:
                FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List client = snapshot.data.docs as List;
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
                                        "Clients",
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
                                        client.length,
                                            (index) =>
                                            Container(
                                              margin:
                                              const EdgeInsets.only(bottom: 20),
                                              child: ListTile(
                                                onTap: () {},
                                                title: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                      child: Text(
                                                        client[index]['name'],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      client[index]['cancel']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w900,
                                                          fontSize: 30,
                                                          color: Colors
                                                              .redAccent),
                                                    ),
                                                  ],
                                                ),
                                                leading: client[index]['image'] ==
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
                                                          client[index]
                                                          ['image']),
                                                    ),
                                                  ),
                                                ),
                                                trailing: client[index]['isAccept']
                                                    ? MaterialButton(
                                                      color:
                                                      Colors.blueAccent,
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            'users')
                                                            .doc(client[index]
                                                        ['id'])
                                                            .set(
                                                          {'isAccept': false},
                                                          SetOptions(
                                                              merge: true),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Block',
                                                        style: TextStyle(
                                                            color:
                                                            Colors.white),
                                                      ),
                                                    )
                                                    : MaterialButton(
                                                  color: Colors.redAccent,
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(client[index]
                                                    ['id'])
                                                        .set(
                                                      {'isAccept': true},
                                                      SetOptions(merge: true),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'UnBlock',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                subtitle: Column(
                                                  children: [
                                                    Text(
                                                        client[index]['email']),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(client[index]
                                                    ['national_id']),
                                                    MaterialButton(
                                                      color:
                                                      Colors.blueAccent,
                                                      onPressed: () async {
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (BuildContext
                                                          context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  "Herafy!!"),
                                                              content:
                                                              StreamBuilder(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                    'users')
                                                                    .doc(client[
                                                                index]
                                                                [
                                                                'id'])
                                                                    .collection(
                                                                    'cancel')
                                                                    .snapshots(),
                                                                builder: (
                                                                    context,
                                                                    AsyncSnapshot
                                                                    snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    List
                                                                    data =
                                                                    snapshot
                                                                        .data
                                                                        .docs as List;
                                                                    return Column(
                                                                      children: List
                                                                          .generate(
                                                                          data
                                                                              .length,
                                                                              (
                                                                              index) =>
                                                                              ListTile(
                                                                                title: Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      bottom: 8),
                                                                                  child: Text(
                                                                                    data[index]['name'],
                                                                                    style: const TextStyle(
                                                                                      fontWeight: FontWeight
                                                                                          .bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                subtitle: Column(
                                                                                  children: [
                                                                                    Text(
                                                                                        data[index]['date']
                                                                                            .toString()),
                                                                                    const SizedBox(
                                                                                      height: 8,
                                                                                    ),

                                                                                  ],
                                                                                ),

                                                                              )),
                                                                    );
                                                                  } else {
                                                                    return const Center(
                                                                      child:
                                                                      CircularProgressIndicator(),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                              actions: <
                                                                  Widget>[
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator
                                                                          .pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                    const Text(
                                                                      'close',
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors
                                                                              .white),
                                                                    ))
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Order Canceled',
                                                        style: TextStyle(
                                                            color:
                                                            Colors.white),
                                                      ),
                                                    ),
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

  Future getClients() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("users").get();
    return qn.docs;
  }
}
