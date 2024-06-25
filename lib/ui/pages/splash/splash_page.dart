import 'dart:io';

import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    confirmValidate();
  }

  void confirmValidate() async {
/*     final root = await controller.initPlatformState();
    if (root) {
      confirmDialog(context);
      return;
    } */

    final userSesion = await controller.validateSession();

    if (userSesion == null) {
      Get.offNamed(AppRoutes.login);
      return;
    }

    if (userSesion.cambiarClave == true) {
      Get.offNamed(AppRoutes.login);
      return;
    }

    Get.offNamed(AppRoutes.home);
  }

  void confirmDialog(BuildContext context) {
    final alert = AlertDialog(
      title: const Text('Acceso denegado'),
      content: const Text(
          'Por motivos de seguridad. FiveSys no puede ser utilizado en dispositivos cuyo sistema operativo no haya sido modificado(Jailbreak o Rooteado).'),
      actions: [
        TextButton(child: const Text('Entendido'), onPressed: () => exit(0))
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.darkTheme.value ? kDarkColor : kWhiteColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/image/logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
