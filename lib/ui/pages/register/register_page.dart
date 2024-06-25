import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/ui/widget/custom_dropdown.dart';
import 'package:app_fivesys/ui/widget/custom_input.dart';

import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/register/components/background.dart';
import 'package:app_fivesys/ui/pages/register/register_controller.dart';

class RegisterPage extends GetWidget<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  Future<void> validateRegistro(BuildContext context, bool darkTheme) async {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    final validation = await controller.validateRegister();
    if (validation != null) {
      final descripcion = validation['mensaje'].toString();
      Get.snackbar(
        'Error',
        descripcion,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      return;
    }

    dialogLoad(context, 'Registrando....', darkTheme);

    final result = await controller.register();

    if (result['ok'] == true) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      final descripcion = result['mensaje'].toString();
      Get.snackbar(
        'Error',
        descripcion,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () {
            final darkTheme = controller.darkTheme.value;
            return Background(
              darkTheme: darkTheme,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: kPrimaryColor,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Registrate",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkTheme ? kWhiteColor : kPrimaryColor,
                          fontSize: 26),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.4),
                  CustomInput(
                    icon: Icons.account_circle,
                    hintText: 'Nombre',
                    controller: controller.nombreTextController,
                    textInputAction: TextInputAction.next,
                    darkTheme: darkTheme,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.4),
                  CustomInput(
                    icon: Icons.account_circle,
                    hintText: 'Apellido',
                    controller: controller.apellidoTextController,
                    textInputAction: TextInputAction.next,
                    darkTheme: darkTheme,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.4),
                  CustomInput(
                    icon: Icons.account_circle,
                    hintText: 'Telefono',
                    controller: controller.telefonoTextController,
                    textInputAction: TextInputAction.next,
                    darkTheme: darkTheme,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.4),
                  CustomDropDown<TipoDocumento>(
                    border: Border.all(
                        color: darkTheme ? Colors.white30 : Colors.black26),
                    icon: Icons.description_outlined,
                    lista: tipoDocumentos,
                    value: controller.tipoDocumentoController.value,
                    darkTheme: darkTheme,
                    onChanged: (value) => controller.updateTipoDocumento(value),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.4),
                  CustomDropDown<TipoDocumento>(
                    border: Border.all(
                        color: darkTheme ? Colors.white30 : Colors.black26),
                    icon: Icons.description_outlined,
                    lista: sectores,
                    value: controller.sectorController.value,
                    darkTheme: darkTheme,
                    onChanged: (value) => controller.updateSector(value),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.4),
                  CustomInput(
                    icon: Icons.account_circle,
                    hintText: 'Nro Documento',
                    controller: controller.nroDocumentoTextController,
                    textInputAction: TextInputAction.next,
                    darkTheme: darkTheme,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.4),
                  CustomInput(
                    icon: Icons.account_circle,
                    hintText: 'Correo',
                    controller: controller.correoTextController,
                    textInputAction: TextInputAction.next,
                    darkTheme: darkTheme,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.5),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {}, // login(context, darkTheme),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(1),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            gradient: LinearGradient(colors: gradients)),
                        padding: const EdgeInsets.all(1),
                        child: const Text(
                          "Registro",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
