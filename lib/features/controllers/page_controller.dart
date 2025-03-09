import 'package:defence_hub_admin_panel/features/dashboard/view/dashboard_view.dart';
import 'package:flutter/material.dart';


class PageControllerProvider with ChangeNotifier {
  Widget _currentPage = DashboardView();  // Varsayılan olarak Dashboard açılsın

  Widget get currentPage => _currentPage;

   int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeMenu(int index) {
    _selectedIndex = index; // Yeni menüyü seç
    notifyListeners(); // Dinleyicilere bildir (Tüm UI güncellenecek)
  }

  void changePage(Widget newPage) {
    _currentPage = newPage;
    notifyListeners();
  }
}
