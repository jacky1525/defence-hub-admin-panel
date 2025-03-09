import 'package:defence_hub_admin_panel/features/authentication/view/auth_screen.dart';
import 'package:defence_hub_admin_panel/features/controllers/auth_controller.dart';
import 'package:defence_hub_admin_panel/features/dashboard/view/dashboard_view.dart';
import 'package:defence_hub_admin_panel/features/dashboard/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//giriş kontrol

mixin AuthScreenMixin on State<AuthScreen> {
  final GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  final ValueNotifier<bool> loginValidateNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasInteractedNotifier = ValueNotifier<bool>(false);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  void onFormChange() {
    loginValidateNotifier.value = authFormKey.currentState?.validate() ?? false;
  }

   login() {
    if (authFormKey.currentState!.validate()) {
      String username = userNameController.text.trim();
      String password = passwordController.text.trim();
      // TODO: Burada giriş işlemi yapılacak (Firebase/Auth ile bağlayabilirsin)
      print("Username: $username, Password: $password");

      if(username == "admin" || password == "admin") {
     context.read<AuthController>().login(); // ✅ **AuthProvider üzerinden giriş yapıldı**
      context.go("/main"); // ✅ **MainScreen'e yönlendir**
    }

    else {
      // ❌ Başarısız giriş -> Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Giriş başarısız! Kullanıcı adı veya şifre yanlış.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating, // Mobildeki gibi yukarıda gösterir
          duration: Duration(seconds: 3), // 3 saniye görünür kalır
        ),
      );
    }
  }

  @override
  void dispose() {
    debugPrint('LoginScreen disposed');
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }
}
}