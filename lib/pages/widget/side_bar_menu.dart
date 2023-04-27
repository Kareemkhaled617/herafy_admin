import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../common/app_colors.dart';
import '../add_category/category.dart';
import '../add_category/listofcategory.dart';
import '../clients/clients.dart';
import '../craftsman/craftsman.dart';
import '../home_page.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.bgSideMenu,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Herafy",
                style: TextStyle(
                  color: AppColor.yellow,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerListTile(
              title: "Dashboard",
              icon: "assets/menu_home.png",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            DrawerListTile(
              title: "Add Category",
              icon: "assets/menu_recruitment.png",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Category()));
              },
            ),
            DrawerListTile(
              title: "Categories",
              icon: "assets/menu_report.png",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListOfCategory(
                              deviceScreenType: DeviceScreenType.desktop,
                            )));
              },
            ),
            DrawerListTile(
              title: "CraftsMan",
              icon: "assets/menu_recruitment.png",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CraftsMan(
                              deviceScreenType: DeviceScreenType.desktop,
                            )));
              },
            ),
            DrawerListTile(
              title: "Clients",
              icon: "assets/menu_recruitment.png",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Clients(
                              deviceScreenType: DeviceScreenType.desktop,
                            )));
              },
            ),
            // DrawerListTile(
            //   title: "Calendar",
            //   icon: "assets/menu_calendar.png",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Settings",
            //   icon: "assets/menu_settings.png",
            //   press: () {},
            // ),
            const Spacer(),
            Image.asset("assets/logo.png")
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, icon;
  final VoidCallback press;

  const DrawerListTile(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        icon,
        color: AppColor.white,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: AppColor.white),
      ),
    );
  }
}
