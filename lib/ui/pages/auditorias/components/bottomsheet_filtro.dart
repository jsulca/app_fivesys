import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';
import 'package:app_fivesys/ui/widget/custom_button.dart';
import 'package:app_fivesys/ui/widget/custom_dropdown.dart';
import 'package:app_fivesys/ui/widget/custom_input.dart';

class BottomSheetFiltro extends StatefulWidget {
  const BottomSheetFiltro({
    Key? key,
    required this.darkTheme,
    required this.isOnline,
    required this.homeController,
  }) : super(key: key);

  final bool darkTheme;
  final bool isOnline;
  final HomeController homeController;

  @override
  State<BottomSheetFiltro> createState() => _BottomSheetFiltroState();
}

class _BottomSheetFiltroState extends State<BottomSheetFiltro> {
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
                        'Busqueda',
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
                  CustomInput(
                    controller: widget.homeController.codigoController,
                    darkTheme: widget.darkTheme,
                    hintText: 'Codigo',
                    icon: Icons.code,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => widget.homeController.updateCodigo(),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomDropDown<TipoDocumento>(
                    border: Border.all(
                      color: widget.darkTheme ? Colors.white30 : Colors.black26,
                    ),
                    darkTheme: widget.darkTheme,
                    hint: const Text('Estado'),
                    icon: Icons.filter_alt,
                    lista: tipoEstados,
                    value: TipoDocumento(
                      id: f.estado,
                      nombre: getEstado(f.estado),
                    ),
                    onChanged: (value) =>
                        widget.homeController.updateEstado(value),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomInput(
                    controller: widget.homeController.areaController,
                    darkTheme: widget.darkTheme,
                    hintText: 'Area',
                    icon: Icons.code,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => widget.homeController.updateArea(),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomInput(
                    controller: widget.homeController.sectorController,
                    darkTheme: widget.darkTheme,
                    hintText: 'Sector',
                    icon: Icons.code,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => widget.homeController.updateSector(),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomInput(
                    controller: widget.homeController.responsableController,
                    darkTheme: widget.darkTheme,
                    hintText: 'Responsable',
                    icon: Icons.code,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) =>
                        widget.homeController.updateResponsable(),
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
    await widget.homeController.initGetFilterAuditorias();
    Navigator.pop(context);
  }

  void confirmButtonOffline(context) async {
    await widget.homeController.getFilterOfflineAuditorias();
    Navigator.pop(context);
  }
}
