import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../component/card_ui.dart';
import 'widget/calender_widget.dart';
import 'widget/header_widget.dart';
import 'widget/notification_card_widget.dart';
import 'widget/profile_card_widget.dart';
import 'widget/recruitment_data_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        NotificationCardWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        buildTaskContent(),
                        const SizedBox(
                          height: 20,
                        ),
                        if (AppResponsive.isMobile(context)) ...{
                          CalendarWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                        },
                        const RecruitmentDataWidget(),
                      ],
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            CalendarWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                            ProfileCardWidget(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
