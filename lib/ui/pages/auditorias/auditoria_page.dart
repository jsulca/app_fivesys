import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/ui/pages/auditorias/main/auditoria_offline_page.dart';
import 'package:app_fivesys/ui/pages/auditorias/main/auditoria_online_page.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';

class AuditoriaPage extends StatefulWidget {
  const AuditoriaPage({Key? key}) : super(key: key);

  @override
  _AuditoriaPageState createState() => _AuditoriaPageState();
}

class _AuditoriaPageState extends State<AuditoriaPage> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeController.getIsOnline(),
      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.data == null) {
          return const Center(child: Text('Cargando..'));
        }
        if (snapshot.data == true) {
          return const AuditoriaOnlinePage();
        }

        return const AuditoriaOffLinePage();
      },
    );
  }
}
