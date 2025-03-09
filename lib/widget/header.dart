import 'package:defence_hub_admin_panel/constants.dart';
import 'package:defence_hub_admin_panel/features/controllers/menu_app_controller.dart';
import 'package:defence_hub_admin_panel/features/controllers/page_controller.dart';
import 'package:defence_hub_admin_panel/features/dashboard/view/dashboard_view.dart';
import 'package:defence_hub_admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final bool isSearchVisible;
  const Header({super.key, this.isSearchVisible = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          TextButton(
            onPressed: () {
                 context.read<PageControllerProvider>().changeMenu(0);
              context.read<PageControllerProvider>().changePage(
                DashboardView(),
              );
            },
            child: Text(
              "Defence Hub Admin Panel",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        if (isSearchVisible) Expanded(child: SearchField()),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Constants.secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(Constants.defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Constants.defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
