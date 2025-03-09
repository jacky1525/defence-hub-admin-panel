import 'package:defence_hub_admin_panel/constants.dart';
import 'package:defence_hub_admin_panel/features/controllers/page_controller.dart';
import 'package:defence_hub_admin_panel/features/dashboard/view/dashboard_view.dart';
import 'package:defence_hub_admin_panel/features/dashboard/view/add_news_view.dart';
import 'package:defence_hub_admin_panel/features/dashboard/view/user_management_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final pageControllerProvider = Provider.of<PageControllerProvider>(context);
    return Drawer(
      backgroundColor: Constants.secondaryColor,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                pageControllerProvider.changeMenu(0);
                pageControllerProvider.changePage(DashboardView());
              },
              child: Text(
                "DASHBOARD",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          DrawerListTile(
            title: "Haber Ekle",
            index: 1,
            isSelected: pageControllerProvider.selectedIndex == 1,
            press: () {
              // Navigate to News Management screen
              pageControllerProvider.changeMenu(1);
              pageControllerProvider.changePage(AddNewsView());
            },
          ),
          Divider(),
          DrawerListTile(
            title: "Kullanıcı Yönetimi",
            index: 2,
            isSelected: pageControllerProvider.selectedIndex == 2,
            press: () {
              // Navigate to News Management screen
              pageControllerProvider.changeMenu(2);
              pageControllerProvider.changePage(UsersManagementView());
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.index,
    required this.isSelected,
  });
  final int index;
  final bool isSelected;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: TextStyle(
          color:
              isSelected ? Colors.white : Colors.white54,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
