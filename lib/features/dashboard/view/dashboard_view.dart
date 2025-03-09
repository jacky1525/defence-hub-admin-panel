import 'package:defence_hub_admin_panel/constants.dart';
import 'package:defence_hub_admin_panel/responsive.dart';
import 'package:defence_hub_admin_panel/widget/header.dart';
import 'package:defence_hub_admin_panel/widget/last_news.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: Constants.defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      LastNews(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: Constants.defaultPadding),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: Constants.defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
               
              ],
            )
          ],
        ),
      ),
    );
  }
}
