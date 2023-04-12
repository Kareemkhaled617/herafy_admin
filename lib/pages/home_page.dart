import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import 'dashboard/dashboard.dart';
import 'widget/side_bar_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SideBar(),
      backgroundColor: AppColor.bgSideMenu,
      body: const SafeArea(
        child: Dashboard(),
      ),
    );
  }
}
