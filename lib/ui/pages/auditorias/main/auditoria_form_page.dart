import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/helpers/util.dart';

import 'package:app_fivesys/ui/pages/auditorias/auditoria_controller.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/custom_menu.dart';
import 'package:app_fivesys/ui/pages/auditorias/form/auditoria_form1_page.dart';
import 'package:app_fivesys/ui/pages/auditorias/form/auditoria_form2_page.dart';
import 'package:app_fivesys/ui/pages/auditorias/form/auditoria_form3_page.dart';
import 'package:app_fivesys/ui/widget/custom_loading.dart';

class AuditoriaFormPage extends StatefulWidget {
  const AuditoriaFormPage({Key? key}) : super(key: key);

  @override
  State<AuditoriaFormPage> createState() => _AuditoriaFormPageState();
}

class _AuditoriaFormPageState extends State<AuditoriaFormPage> {
  final _pageController = PageController();
  final auditoriaController = Get.find<AuditoriaController>();
  final dynamic arguments = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (arguments['isOnline'] == true) {
      auditoriaController.syncAuditoria(arguments['auditoriaId'] as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auditoriaId = arguments['auditoriaId'] as int;
    final estado = arguments['estado'] as int;
    final isOnline = arguments['isOnline'] as bool;
    final token = arguments['token'] as String;

    // return WillPopScope(
    //   onWillPop: () => onWillPop(isOnline, auditoriaId),
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => onWillPop(isOnline, auditoriaId),
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding + 10),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) => pageChanged(index),
                    children: [
                      if (auditoriaController.auditoriaState.value !=
                          AuditoriaState.loading) ...{
                        AuditoriaForm1Page(auditoriaId, estado, isOnline),
                        AuditoriaForm2Page(
                            auditoriaId, estado, isOnline, token),
                        AuditoriaForm3Page(
                            auditoriaId, estado, isOnline, token),
                      }
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: _MenuLocation(
                    pageController: _pageController,
                    controller: auditoriaController,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Get.offAllNamed(AppRoutes.home),
                    ),
                    backgroundColor: Colors.blue
                        .withOpacity(0.0), //You can make this transparent
                    elevation: 0.0,
                  ),
                ),
                Positioned.fill(
                  child: (auditoriaController.auditoriaState.value ==
                          AuditoriaState.loading)
                      ? const CustomLoading()
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 4),
          child: Visibility(
            visible: isOnline,
            child: FloatingActionButton(
              heroTag: "fab1",
              elevation: kDefaultPadding / 2,
              onPressed: () => estado == 0 || estado == 1
                  ? confirmDialog(context, auditoriaId)
                  : showSnackBar('Inhabilitado para editar 2', context),
              child: const Icon(Icons.save),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  Future<bool> onWillPop(bool isOnline, int auditoriaId) async {
    final textContent = isOnline
        ? 'Se eliminaran los cambios al salir?'
        : 'Se guardaran los cambios al salir';
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mensaje'),
        content: Text(textContent),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              if (isOnline) {
                await auditoriaController.closeAuditoria(auditoriaId);
              }

              Navigator.of(context).pop(true);
              Get.offAllNamed(AppRoutes.home);
            },
            child: const Text('Entiendo'),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  void pageChanged(int index) {
    FocusScope.of(context).requestFocus(FocusNode());
    auditoriaController.changeItemSeleccionado(index);
    auditoriaController.changeMostrar(isChange: true);
  }

  void confirmDialog(BuildContext context, auditoriaId) {
    final AlertDialog alert = AlertDialog(
      title: const Text('Mensaje'),
      content: const Text('Deseas enviar registro ?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Continue'),
          onPressed: () {
            auditoriaController.sendAuditoria(auditoriaId);
            Navigator.of(context).pop(true);
          },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class _MenuLocation extends StatelessWidget {
  const _MenuLocation({
    required this.pageController,
    required this.controller,
  });
  final PageController pageController;
  final AuditoriaController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Obx(
        () {
          final darkTheme = controller.darkTheme.value;
          return CustomMenuAuditoria(
            mostrar: controller.mostrar.value,
            backgroundColor: darkTheme ? kDarkColor : kPrimaryColor,
            activeColor: kAccentColor,
            inactiveColor: darkTheme ? kWhiteColor : kWhiteColor,
            controller: controller,
            items: [
              ItemsButton(
                icon: 'assets/icon/ic_donut.svg',
                title: "General",
                onPressed: () {
                  pageController.animateToPage(0,
                      duration: kDefaultTime, curve: Curves.ease);
                },
              ),
              ItemsButton(
                icon: 'assets/icon/ic_auditorias.svg',
                title: "Observaciones",
                onPressed: () {
                  pageController.animateToPage(1,
                      duration: kDefaultTime, curve: Curves.ease);
                },
              ),
              ItemsButton(
                icon: 'assets/icon/ic_info.svg',
                title: "Puntos Fijos",
                onPressed: () {
                  pageController.animateToPage(2,
                      duration: kDefaultTime, curve: Curves.ease);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
