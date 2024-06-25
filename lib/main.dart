import 'package:app_fivesys/helpers/notification_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'helpers/app_navigation.dart';
import 'helpers/util.dart';
import 'ui/main_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App FiveSYS',
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      initialBinding: MainBinding(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
