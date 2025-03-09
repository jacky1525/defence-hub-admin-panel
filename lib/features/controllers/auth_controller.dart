import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = true; // ✅ Yüklenme durumu eklendi

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading; // ✅ Dışarıdan erişim için getter

  AuthController() {
    _loadLoginStatus(); // ✅ Uygulama açıldığında giriş durumunu yükle
  }

  Future<void> _loadLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    _isLoading = false; // ✅ Yüklenme tamamlandı
    notifyListeners();
  }

  Future<void> login() async {
    _isLoggedIn = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    notifyListeners();
  }
}