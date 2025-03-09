import 'dart:async';

import 'package:defence_hub_admin_panel/bloc/news/news_bloc_exports.dart';
import 'package:defence_hub_admin_panel/bloc/user/user_bloc.dart';
import 'package:defence_hub_admin_panel/constants.dart';
import 'package:defence_hub_admin_panel/features/authentication/data/auth_repository.dart';
import 'package:defence_hub_admin_panel/features/authentication/view/auth_screen.dart';
import 'package:defence_hub_admin_panel/features/controllers/auth_controller.dart';
import 'package:defence_hub_admin_panel/features/controllers/menu_app_controller.dart';
import 'package:defence_hub_admin_panel/features/controllers/page_controller.dart';
import 'package:defence_hub_admin_panel/features/dashboard/view/main_screen.dart';
import 'package:defence_hub_admin_panel/services/firebase_service.dart';
import 'package:defence_hub_admin_panel/widget/edit_news_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Future.microtask(() async {
    // 🟢 runApp'i microtask içine aldık!
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCs7kE6rSx3tv533h0kE8c2bYUL8YS6LJ4",
        authDomain: "defencehub-ac98f.firebaseapp.com",
        projectId: "defencehub-ac98f",
        storageBucket: "defencehub-ac98f.firebasestorage.app",
        messagingSenderId: "913567703333",
        appId: "1:913567703333:web:c6056bac36a550e4063acc",
      ),
    );

    final firebaseAuthService = FirebaseAuthService();
    final authRepository = AuthRepository(firebaseAuthService);
    authRepository.getNewsFromFirestore();
    authRepository.getUsersFromFirestore();

    runApp(
      MyApp(authRepository: authRepository),
    ); // 🟢 Mikro görev olarak çağrıldı
  });
}

final GoRouter router = GoRouter(
initialLocation: "/login",
  routes: [
    GoRoute(
      path: "/login",
      builder: (context, state) => AuthScreen(),
    ),
    GoRoute(
      path: "/main",
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: "/news-edit/:id", // ✅ **Haber düzenleme sayfası**
      builder: (context, state) {
        String documentId = state.pathParameters["id"]!; // **Route'dan ID'yi al**
        return EditNewsView(documentId: documentId);
      },
    ),
  ],
  redirect: (context, state) {
    final authProvider = context.read<AuthController>();

    // ✅ Eğer yükleme devam ediyorsa, yönlendirme yapma
    if (authProvider.isLoading) return null;

    if (!authProvider.isLoggedIn && state.uri.toString() != "/login") {
      return "/login"; // Kullanıcı giriş yapmamışsa login sayfasına yönlendir
    }
    if (authProvider.isLoggedIn && state.uri.toString() == "/login") {
      return "/main"; // Eğer giriş yapmışsa login'e geri gidemez
    }
    return null; // Hiçbir yönlendirme gerekmiyorsa olduğu sayfada kal
  },

);

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuAppController()),
        ChangeNotifierProvider(create: (context) => PageControllerProvider()),
           ChangeNotifierProvider(create: (context) => AuthController()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => NewsBloc(authRepository)..add(FetchNewsEvent()),
          ),
          BlocProvider(
            create:
                (context) => UserBloc(authRepository)..add(FetchUserEvent()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter DefenceHub Admin Panel',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Constants.dashboardBackgroundColor,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ).apply(bodyColor: Colors.white),
            canvasColor: Constants.secondaryColor,
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
