import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/cardview_auditoria.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/header_menu.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';

class AuditoriaOffLinePage extends StatefulWidget {
  const AuditoriaOffLinePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuditoriaOffLinePage> createState() => _AuditoriaOffLinePageState();
}

class _AuditoriaOffLinePageState extends State<AuditoriaOffLinePage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final controller = ScrollController();
  final homeController = Get.find<HomeController>();
  var scrollAnterior = 0.0;

  @override
  void initState() {
    homeController.getOfflineAuditorias();

    controller.addListener(() {
      if (controller.offset > scrollAnterior && controller.offset > 50) {
        homeController.changeMostrar(isChange: false);
      } else {
        homeController.changeMostrar(isChange: true);
      }
      scrollAnterior = controller.offset;

      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        if (homeController.isFilter) {
          homeController.getFilterOfflineAuditorias();
        } else {
          homeController.getOfflineAuditorias();
        }
      }
    });

    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = const Duration(milliseconds: 1500);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final darkTheme = homeController.darkTheme.value;
          return SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  controller: controller,
                  slivers: [
                    SliverPersistentHeader(
                      delegate: HeaderMenu(
                        isOnline: false,
                        darkTheme: darkTheme,
                        homeController: homeController,
                        animationController: animationController,
                      ),
                      pinned: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final auditoria = homeController.auditorias[i];
                          return CardViewAuditoria(
                            auditor: auditoria,
                            index: i,
                            darkTheme: darkTheme,
                            isOnline: false,
                            onPressEdit: () async {
                              final token = await homeController.getToken();

                              Get.offAllNamed(
                                AppRoutes.auditoria,
                                arguments: {
                                  'auditoriaId': auditoria.auditoriaId,
                                  'estado': auditoria.estado,
                                  'isOnline': false,
                                  'token': token
                                },
                              );
                            },
                            onPressEmail: () => confirmDeleteAuditoria(
                                auditoria.auditoriaId, i),
                            onPressPdf: () {},
                            onChangedOffline: (value) {},
                          );
                        },
                        childCount: homeController.auditorias.length,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void confirmDeleteAuditoria(int id, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mensaje'),
        content: const Text('Deseas eliminar esta Auditoria?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            child: const Text('Entiendo'),
            onPressed: () {
              homeController.deleteAuditoria(id, index);
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }
}
