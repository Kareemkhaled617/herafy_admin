import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardTaskData {
  final String label;
  final String jobDesk;
  final DateTime dueDate;

  const CardTaskData({
    required this.label,
    required this.jobDesk,
    required this.dueDate,
  });
}

class CardTask extends StatelessWidget {
  const CardTask({
    required this.data,
    required this.primary,
    required this.onPrimary,
    Key? key,
  }) : super(key: key);

  final data;
  final Color primary;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(.7)],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
            child: _BackgroundDecoration(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLabel(),
                          const SizedBox(height: 20),
                          _buildJobdesk(),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDate(),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            thickness: 1,
                            color: onPrimary,
                          ),
                        ),
                        _buildHours(),
                      ],
                    ),
                    const Spacer(flex: 2),
                    _doneButton(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        String docId = FirebaseFirestore.instance
                            .collection('category')
                            .doc(data['type'])
                            .collection('services')
                            .doc()
                            .id;
                        await FirebaseFirestore.instance
                            .collection('allService')
                            .doc(data['id'])
                            .set(
                          {
                            'isAccept': 2,
                          },
                          SetOptions(merge: true),
                        );
                        await FirebaseFirestore.instance
                            .collection('category')
                            .doc(data['type'])
                            .collection('services')
                            .doc(docId)
                            .set({
                          'image': data['image'],
                          'isAccept': 2,
                          "name": data['name'],
                          "des": data['des'],
                          'type': data['type'],
                          'craftsman': data['craftsman'],
                          'price': data['price'],
                          'servicesId': docId,
                          'id': data['id'],
                          'craftManId': data['uid'],
                          'time': DateFormat('hh:mm a')
                              .format(DateTime.now())
                              .toString(),
                          'date': DateFormat('yyyy-MM-dd')
                              .format(DateTime.now())
                              .toString(),
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: onPrimary,
                        onPrimary: primary,
                      ),
                      icon: const Icon(Icons.cancel),
                      label: const Text("Reject"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      data['name'],
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: onPrimary,
        letterSpacing: 1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildJobdesk() {
    return Container(
      decoration: BoxDecoration(
        color: onPrimary.withOpacity(.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        data['craftsman'],
        style: TextStyle(
          color: onPrimary,
          fontSize: 10,
          letterSpacing: 1,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDate() {
    return _IconLabel(
      color: onPrimary,
      iconData: Icons.calendar_today_outlined,
      label: data['date'],
    );
  }

  Widget _buildHours() {
    return _IconLabel(
      color: onPrimary,
      iconData: Icons.watch_later,
      label: data['time'],
    );
  }

  Widget _doneButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        String docId = FirebaseFirestore.instance
            .collection('category')
            .doc(data['type'])
            .collection('services')
            .doc()
            .id;
        await FirebaseFirestore.instance
            .collection('allService')
            .doc(data['id'])
            .set(
          {
            'isAccept': 1,
          },
          SetOptions(merge: true),
        );
        await FirebaseFirestore.instance
            .collection('category')
            .doc(data['type'])
            .collection('services')
            .doc(docId)
            .set({
          'image': data['image'],
          'isAccept': 1,
          "name": data['name'],
          "des": data['des'],
          'type': data['type'],
          'craftsman': data['craftsman'],
          'price': data['price'],
          'servicesId': docId,
          'id': data['id'],
          'craftManId': data['uid'],
          'time': DateFormat('hh:mm a').format(DateTime.now()).toString(),
          'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        });
      },
      style: ElevatedButton.styleFrom(
        primary: onPrimary,
        onPrimary: primary,
      ),
      icon: const Icon(Icons.done),
      label: const Text("Accept"),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.color,
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 18,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(.8),
          ),
        )
      ],
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: const Offset(25, -25),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Transform.translate(
            offset: const Offset(-70, 70),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  String formatdMMMMY() {
    return DateFormat('d MMMM y').format(this);
  }

  String dueDate() {
    DateTime due = this;
    Duration diff = due.difference(DateTime.now());

    if (diff.inDays > 1) {
      return "${diff.inDays} Days";
    } else if (diff.inHours > 1) {
      return "${diff.inHours} Hours";
    } else if (diff.inMinutes > 1) {
      return "${diff.inMinutes} Minutes";
    } else if (diff.inSeconds > 1) {
      return "${diff.inSeconds} Seconds";
    } else {
      return "Is Overdue";
    }
  }
}
