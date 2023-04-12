import 'package:flutter/material.dart';
import 'package:herafy_admin_web_part/pages/craftsman/craftsmanservices.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MemberCard extends StatelessWidget {
  final member;
  final bool showJob;
  final Widget? trailing;
  final DeviceScreenType deviceScreenType;

  const MemberCard(
      {Key? key,
      required this.deviceScreenType,
      this.showJob = false,
      required this.member,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CraftsManServices(
                      deviceScreenType: DeviceScreenType.desktop,
                      id: member['id'])));
        },
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            member['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: member['image'] == 'null'
            ? const CircleAvatar(
                child: Icon(Icons.person),
              )
            : Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(member['image']),
                  ),
                ),
              ),
        trailing: const Text(''),
        subtitle: Column(
          children: [
            Text(member['email']),
            const SizedBox(
              height: 8,
            ),
            Text(member['phone']),
          ],
        ),
      ),
    );
  }
}

class KColor {
  static Color iconColor = const Color(0xFF9BA6BB);
  static Color primaryColor = const Color(0xFF7F00DD);
}

class MessageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Scouting Group",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Wellcome to Stream line scouting chat",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "We can now freely collaborate regarding our current demand\n"
                    "Any question about the documentaion or the project\n"
                    "please feel free to get in contact us\n",
                    style: TextStyle(
                        color: Color(0xff78A1C6),
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tuesdy, April 7th at 1:21PM",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMessage(
                                "Awesome! it's going to be amzing deal!"),
                            _buildMessage("I've run through different docs"),
                            _buildMessage("Hope for the best"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildMessage(
                              "Thanks for the sending the deal, I'll review it",
                              isSend: true,
                            ),
                            _buildMessage(
                              "and getback to you shortly",
                              isSend: true,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const CircleAvatar(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.attach_file), onPressed: () {}),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Write message..",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildMessage(String message, {bool isSend = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSend ? KColor.primaryColor : Colors.grey[300]?.withOpacity(.4),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Text(
        message,
        style: TextStyle(color: isSend ? Colors.white : null),
      ),
    );
  }
}
