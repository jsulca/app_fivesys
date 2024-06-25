import 'package:app_fivesys/ui/main_binding.dart';
import 'package:get/route_manager.dart';

import 'package:app_fivesys/ui/pages/auditorias/auditoria_binding.dart';
import 'package:app_fivesys/ui/pages/auditorias/main/auditoria_form_page.dart';
import 'package:app_fivesys/ui/pages/home/home_binding.dart';
import 'package:app_fivesys/ui/pages/home/home_page.dart';
import 'package:app_fivesys/ui/pages/login/login_binding.dart';
import 'package:app_fivesys/ui/pages/login/login_page.dart';
import 'package:app_fivesys/ui/pages/register/register_binding.dart';
import 'package:app_fivesys/ui/pages/register/register_page.dart';
import 'package:app_fivesys/ui/pages/splash/splash_binding.dart';
import 'package:app_fivesys/ui/pages/splash/splash_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String auditoria = '/auditoria';
  static const String register = '/register';
}

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      bindings: [SplashBinding()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      bindings: [MainBinding(), RegisterBinding()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      bindings: [MainBinding(), HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.auditoria,
      page: () => const AuditoriaFormPage(),
      bindings: [MainBinding(), AuditoriaBinding()],
    ),
  ];
}
