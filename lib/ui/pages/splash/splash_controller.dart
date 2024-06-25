import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/data/repository/api_repository.dart';
import 'package:app_fivesys/data/repository/local_repository.dart';

class SplashController extends GetxController {
  final LocalRepository localRepository;
  final ApiRepository apiRepository;

  SplashController({
    required this.localRepository,
    required this.apiRepository,
  });

  RxBool darkTheme = false.obs;

  @override
  void onInit() {
    validateTheme();
    super.onInit();
  }

  Future<void> validateTheme() async {
    final verificateTheme = await localRepository.isDarkMode();
    if (verificateTheme == null) {
      await localRepository.saveDarkMode(Get.isDarkMode);
    }
    final isDark = await localRepository.isDarkMode();
    darkTheme(isDark);
    Get.changeThemeMode(isDark! ? ThemeMode.dark : ThemeMode.light);
  }

  Future<Usuario?> validateSession() async {
    return await localRepository.getExistUsuario();
  }

  Future<bool> initPlatformState() async {
    bool jailbroken;
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      jailbroken = true;
    }

    return jailbroken;
  }
}
