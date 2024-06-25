import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/domain/models/offline.dart';
import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';
import 'package:app_fivesys/ui/widget/custom_button.dart';
import 'package:app_fivesys/ui/widget/custom_dropdown.dart';
import 'package:app_fivesys/ui/widget/custom_input.dart';

class BottomSheetNew extends StatefulWidget {
  const BottomSheetNew({
    Key? key,
    required this.darkTheme,
    required this.isOnline,
    required this.homeController,
  }) : super(key: key);

  final bool darkTheme;
  final bool isOnline;
  final HomeController homeController;

  @override
  State<BottomSheetNew> createState() => _BottomSheetNewState();
}

class _BottomSheetNewState extends State<BottomSheetNew> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: widget.darkTheme ? kDarkColor : kWhiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(80),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding / 2,
          ),
          child: SingleChildScrollView(
            child: Obx(() {
              final f = widget.homeController.filtro.value;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: kDefaultPadding * 2),
                      const Text(
                        'Nueva Auditoria',
                        style: TextStyle(
                          fontSize: kDefaultPadding,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomDropDown<OrganizacionFiltro>(
                    border: Border.all(
                      color: widget.darkTheme ? Colors.white30 : Colors.black26,
                    ),
                    darkTheme: widget.darkTheme,
                    hint: const Text('Organización'),
                    icon: Icons.group,
                    lista: widget.homeController.organizaciones,
                    value: (f.organizacionId != 0)
                        ? OrganizacionFiltro(
                            organizacionId: f.organizacionId,
                            nombre: f.organizacionNombre,
                          )
                        : null,
                    onChanged: (value) =>
                        widget.homeController.changeOrganizacion(value!),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomDropDown<AreaFiltro>(
                    border: Border.all(
                      color: widget.darkTheme ? Colors.white30 : Colors.black26,
                    ),
                    darkTheme: widget.darkTheme,
                    hint: const Text('Area'),
                    icon: Icons.crop_square,
                    lista: widget.homeController.areas,
                    value: (f.areaId != 0)
                        ? AreaFiltro(
                            areaId: f.areaId,
                            nombre: f.areaNombre,
                          )
                        : null,
                    onChanged: (value) =>
                        widget.homeController.changeArea(value!),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomDropDown<SectorFiltro>(
                    border: Border.all(
                      color: widget.darkTheme ? Colors.white30 : Colors.black26,
                    ),
                    darkTheme: widget.darkTheme,
                    hint: const Text('Sector'),
                    icon: Icons.place,
                    lista: widget.homeController.sectores,
                    value: (f.sectorId != 0)
                        ? SectorFiltro(
                            sectorId: f.sectorId,
                            nombre: f.sectorNombre,
                          )
                        : null,
                    onChanged: (value) =>
                        widget.homeController.changeSector(value!),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomDropDown<ResponsableFiltro>(
                    border: Border.all(
                      color: widget.darkTheme ? Colors.white30 : Colors.black26,
                    ),
                    darkTheme: widget.darkTheme,
                    hint: const Text('Responsable'),
                    icon: Icons.person,
                    lista: widget.homeController.responsables,
                    value: (f.responsableId != 0)
                        ? ResponsableFiltro(
                            responsableId: f.responsableId,
                            nombreCompleto: f.responsable,
                          )
                        : null,
                    onChanged: (value) =>
                        widget.homeController.changeResponsable(value!),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: CustomInput(
                      controller: widget.homeController.nombreController,
                      darkTheme: widget.darkTheme,
                      hintText: 'Nombre',
                      icon: Icons.code,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) =>
                          widget.homeController.updateNombre(),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 2),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('S1',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Checkbox(
                          value: f.s1,
                          activeColor: kPrimaryColor,
                          onChanged: (onChanged) =>
                              widget.homeController.updateS1toS5(onChanged, 1)),
                      const Text('S2',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Checkbox(
                          value: f.s2,
                          activeColor: kPrimaryColor,
                          onChanged: (onChanged) =>
                              widget.homeController.updateS1toS5(onChanged, 2)),
                      const Text('S3',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Checkbox(
                          value: f.s3,
                          activeColor: kPrimaryColor,
                          onChanged: (onChanged) =>
                              widget.homeController.updateS1toS5(onChanged, 3)),
                      const Text('S4',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Checkbox(
                          activeColor: kPrimaryColor,
                          value: f.s4,
                          onChanged: (onChanged) =>
                              widget.homeController.updateS1toS5(onChanged, 4)),
                      const Text('S5',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Checkbox(
                          value: f.s5,
                          activeColor: kPrimaryColor,
                          onChanged: (onChanged) =>
                              widget.homeController.updateS1toS5(onChanged, 5)),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      title: 'Aceptar',
                      onPress: () => widget.isOnline
                          ? confirmButton(context)
                          : confirmButtonOffline(context),
                      darkTheme: widget.darkTheme,
                      width: size.width * 0.4,
                      isLoad: widget.homeController.state.value ==
                          HomeState.loading,
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void confirmButton(context) async {
    final data = await widget.homeController.generateAuditoria();
    if (data['result'] == true) {
      Navigator.pop(context);
      Get.toNamed(
        AppRoutes.auditoria,
        arguments: data,
      );
    } else {
      Get.snackbar(
        'Mensaje',
        data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 20, 14, 14),
        colorText: Colors.white,
      );

      if (data['status'] == 401) {
        await widget.homeController.logOut();
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }

  void confirmButtonOffline(context) async {
    final data = await widget.homeController.generateAuditoriaOffline();
    if (data['result'] == true) {
      Navigator.pop(context);
      Get.toNamed(
        AppRoutes.auditoria,
        arguments: data,
      );
    } else {
      Get.snackbar(
        'Mensaje',
        data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }
}
