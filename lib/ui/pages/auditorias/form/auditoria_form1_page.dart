import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/auditorias/auditoria_controller.dart';
import 'package:app_fivesys/ui/widget/custom_dropdown.dart';

class AuditoriaForm1Page extends StatefulWidget {
  const AuditoriaForm1Page(this.auditoriaId, this.estado, this.isOnline,
      {Key? key})
      : super(key: key);
  final int auditoriaId;
  final int estado;
  final bool isOnline;

  @override
  State<AuditoriaForm1Page> createState() => _AuditoriaForm1PageState();
}

class _AuditoriaForm1PageState extends State<AuditoriaForm1Page> {
  final auditoriaController = Get.find<AuditoriaController>();

  @override
  void initState() {
    auditoriaController.getAuditoriaById(widget.auditoriaId);

    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (visible) {
        auditoriaController.changeMostrar(isChange: false);
      } else {
        auditoriaController.changeMostrar(isChange: true);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () {
          final auditoria = auditoriaController.auditoria.value;
          final darkTheme = auditoriaController.darkTheme.value;

          return Container(
            margin: const EdgeInsets.all(kDefaultPadding),
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            decoration:
                getThemeBoxDecoration(darkTheme: darkTheme, blurRadius: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Codigo
                const SizedBox(height: kDefaultPadding / 2),
                TextField(
                  controller: auditoriaController.codigoController,
                  decoration: getTextFieldInputDecoration('Codigo'),
                  enableInteractiveSelection: false,
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                ),
                //Organización
                const SizedBox(height: kDefaultPadding / 2),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: auditoriaController.organizacionController,
                  decoration: getTextFieldInputDecoration('Organizacion'),
                  enableInteractiveSelection: false,
                  style: TextStyle(color: darkTheme ? kWhiteColor : null),
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                ),
                //Area
                const SizedBox(height: kDefaultPadding / 2),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: auditoriaController.areaController,
                  decoration: getTextFieldInputDecoration('Area'),
                  enableInteractiveSelection: false,
                  style: TextStyle(color: darkTheme ? kWhiteColor : null),
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                ),
                //Sector
                const SizedBox(height: kDefaultPadding / 2),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: auditoriaController.sectorController,
                  decoration: getTextFieldInputDecoration('Sector'),
                  enableInteractiveSelection: false,
                  style: TextStyle(color: darkTheme ? kWhiteColor : null),
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                ),
                //Responsable
                const SizedBox(height: kDefaultPadding / 2),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: auditoriaController.responsableController,
                  decoration: getTextFieldInputDecoration('Responsable'),
                  enableInteractiveSelection: false,
                  style: TextStyle(color: darkTheme ? kWhiteColor : null),
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                ),
                //Nombre
                const SizedBox(height: kDefaultPadding / 2),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: auditoriaController.nombreController,
                  decoration: getTextFieldInputDecoration('Nombre'),
                  enableInteractiveSelection: false,
                  style: TextStyle(color: darkTheme ? kWhiteColor : null),
                  readOnly: !(widget.isOnline && (widget.estado == 0 || widget.estado == 1)),
                  onChanged: (value) => auditoriaController.updateNombre(),
                ),

                const SizedBox(height: kDefaultPadding / 2),
                CustomDropDown<TipoDocumento>(
                  background: darkTheme ? null : kWhiteColor,
                  border: Border.all(
                    color: darkTheme ? Colors.white30 : Colors.black26,
                  ),
                  darkTheme: darkTheme,
                  // enabled: ,
                  enabled: !(widget.isOnline && (widget.estado == 0 || widget.estado == 1)),
                  isTitle: true,
                  lista: tipoEstados,
                  onChanged: (value) => auditoriaController.updateEstado(value),
                  title: 'Estado',
                  value: TipoDocumento(
                    id: auditoria?.estado ?? 0,
                    nombre: getEstado(auditoria?.estado ?? 0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
