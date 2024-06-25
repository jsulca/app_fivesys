import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/cardview_auditoria.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/bottomsheet_email.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/header_menu.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';

import 'package:app_fivesys/helpers/util.dart';

class AuditoriaOnlinePage extends StatefulWidget {
  const AuditoriaOnlinePage({Key? key}) : super(key: key);

  @override
  State<AuditoriaOnlinePage> createState() => _AuditoriaOnlinePageState();
}

class _AuditoriaOnlinePageState extends State<AuditoriaOnlinePage>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  final controller = ScrollController();
  final homeController = Get.find<HomeController>();
  var scrollAnterior = 0.0;

  @override
  void initState() {
    tz.initializeTimeZones();

    homeController.initGetAuditorias();

    controller.addListener(() {
      if (controller.offset > scrollAnterior && controller.offset > 50) {
        homeController.changeMostrar(isChange: false);
      } else {
        homeController.changeMostrar(isChange: true);
      }
      scrollAnterior = controller.offset;

      if (controller.position.pixels >= controller.position.maxScrollExtent &&
          !homeController.cargandoAuditorias.value) {
        if (homeController.isFilter) {
          homeController.getFilterAuditorias();
        } else {
          homeController.getAuditorias();
        }
      }
    });

    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = kDefaultTime;
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
                if (homeController.stateAuditoria.value ==
                    HomeState.loading) ...{
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                } else ...{
                  RefreshIndicator(
                    onRefresh: () async {
                      if (homeController.isFilter) {
                        homeController.getFilterAuditorias();
                      } else {
                        homeController.initGetAuditorias();
                      }
                    },
                    child: CustomScrollView(
                      controller: controller,
                      slivers: [
                        SliverPersistentHeader(
                          delegate: HeaderMenu(
                            isOnline: true,
                            darkTheme: darkTheme,
                            homeController: homeController,
                            animationController: animationController,
                          ),
                          pinned: true,
                        ),
                        (homeController.auditorias.isEmpty)
                            ? const SliverFillRemaining(
                                hasScrollBody: false,
                                child: SizedBox(
                                  height: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'No hay datos',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, i) {
                                    final auditoria =
                                        homeController.auditorias[i];
                                    return CardViewAuditoria(
                                      auditor: auditoria,
                                      index: i,
                                      darkTheme: darkTheme,
                                      isOnline: true,
                                      onPressEdit: () async {
                                        final token =
                                            await homeController.getToken();

                                        Get.offAllNamed(
                                          AppRoutes.auditoria,
                                          arguments: {
                                            'auditoriaId':
                                                auditoria.auditoriaId,
                                            'estado': auditoria.estado,
                                            'isOnline': true,
                                            'token': token
                                          },
                                        );
                                      },
                                      onPressEmail: () => showModalBottomEmail(
                                        context,
                                        darkTheme,
                                        auditoria.auditoriaId,
                                      ),
                                      onChangedOffline: (value) =>
                                          homeController.updateAuditoriaOffLine(
                                              i, value ?? false),
                                      onPressPdf: () => homeController
                                          .downloadPdf(auditoria.auditoriaId),
                                    );
                                  },
                                  childCount: homeController.auditorias.length,
                                ),
                              )
                      ],
                    ),
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }

  void showModalBottomEmail(context, darkTheme, auditoriaId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      transitionAnimationController: animationController,
      builder: (context) => BottomSheetEmail(
        darkTheme: darkTheme,
        homeController: homeController,
        auditoriaId: auditoriaId,
      ),
    );
  }
}
