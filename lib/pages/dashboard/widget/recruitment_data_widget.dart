import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../controllers/controller.dart';

class RecruitmentDataWidget extends StatefulWidget {
  const RecruitmentDataWidget({super.key});

  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getServicesData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List;
            return Container(
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "allService",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      /// Table Header
                      TableRow(
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          )),
                        ),
                        children: [
                          tableHeader("Name"),
                          if (!AppResponsive.isMobile(context))
                            tableHeader("craftsman"),
                          tableHeader("Category"),
                          tableHeader("price"),
                          tableHeader("isAccept"),
                        ],
                      ),
                      ...data.map(
                        (element) => tableRow(
                          context,
                          name: element['name'] ?? '',
                          isAccept: element['isAccept'],
                          color:
                              element['isAccept'] ? Colors.green : Colors.red,
                          image: element['image'] ?? '',
                          type: element['type'] ?? '',
                          uid: element['id'] ?? '',
                          price: element['price'] ?? '',
                          craftsman: element['craftsman'] ?? '',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  TableRow tableRow(context,
      {uid, image, name, isAccept, price, type, craftsman, color}) {
    return TableRow(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        children: [
          //Full Name
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text(
                  name,
                  maxLines: 3,
                ))
              ],
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) Text(craftsman),
          if (!AppResponsive.isMobile(context)) Text(type),
          if (!AppResponsive.isMobile(context)) Text(price),
          //Status
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                height: 10,
                width: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(isAccept.toString()),
            ],
          ),
          // Menu icon
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
      ),
    );
  }
}
