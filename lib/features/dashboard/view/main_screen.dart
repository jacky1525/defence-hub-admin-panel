import 'package:defence_hub_admin_panel/features/controllers/menu_app_controller.dart';
import 'package:defence_hub_admin_panel/features/controllers/page_controller.dart';
import 'package:defence_hub_admin_panel/responsive.dart';
import 'package:defence_hub_admin_panel/widget/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: context.read<MenuAppController>().scaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: Consumer<PageControllerProvider>(
                  builder: (context, pageController, child) {
                    return pageController.currentPage; // Seçilen sayfayı göster
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
