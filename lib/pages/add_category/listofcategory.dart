import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../test.dart';
import '../widget/side_bar_menu.dart';
import 'category.dart';

class ListOfCategory extends StatelessWidget {
  final DeviceScreenType deviceScreenType;

  const ListOfCategory({Key? key, required this.deviceScreenType})
      : super(key: key);

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
                future: getCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List category = snapshot.data as List;
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
                                        "Categories",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                      const Spacer(),
                                      const SizedBox(width: 20),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Category()));
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    children: List.generate(
                                      category.length,
                                      (index) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: ListTile(
                                          onTap: () {
                                            if (deviceScreenType ==
                                                    DeviceScreenType.mobile ||
                                                deviceScreenType ==
                                                    DeviceScreenType.tablet) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return Scaffold(
                                                      body: MessageBox(),
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                              category[index]['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  category[index]['image'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          trailing:  Text(category[index]['time'].toString()),
                                          subtitle: const Text(''),
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

  Future getCategory() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("category").get();
    return qn.docs;
  }
}
