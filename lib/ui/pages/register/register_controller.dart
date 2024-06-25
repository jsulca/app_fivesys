import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/data/repository/api_repository.dart';
import 'package:app_fivesys/data/repository/local_repository.dart';
import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/domain/response/response.dart';

enum RegisterState {
  loading,
  initial,
}

class RegisterController extends GetxController {
  final LocalRepository localRepository;
  final ApiRepository apiRepository;

  RegisterController({
    required this.localRepository,
    required this.apiRepository,
  });

  final nombreTextController = TextEditingController();
  final apellidoTextController = TextEditingController();
  final telefonoTextController = TextEditingController();
  final nroDocumentoTextController = TextEditingController();
  final correoTextController = TextEditingController();

  Rx<TipoDocumento> tipoDocumentoController =
      TipoDocumento(id: 3, nombre: 'L.E / DNI').obs;

  Rx<TipoDocumento> sectorController =
      TipoDocumento(id: 1, nombre: 'Industrial').obs;

  RxBool darkTheme = false.obs;

  @override
  void onInit() {
    validateTheme();
    super.onInit();
  }

  Future<void> validateTheme() async {
    final dark = await localRepository.isDarkMode();
    darkTheme(dark);
  }

  Rx<RegisterState> registerState = RegisterState.initial.obs;

  void updateTipoDocumento(TipoDocumento? value) {
    tipoDocumentoController(value);
  }

  void updateSector(TipoDocumento? value) {
    sectorController(value);
  }

  Future<Map<String, dynamic>?> validateRegister() async {
    final nombre = nombreTextController.text;
    final apellido = apellidoTextController.text;
    final telefono = telefonoTextController.text;
    final nroDocumento = nroDocumentoTextController.text;
    final correo = correoTextController.text;

    if (nombre.isEmpty) {
      return {'ok': false, 'mensaje': 'Ingrese Nombre.'};
    }
    if (apellido.isEmpty) {
      return {'ok': false, 'mensaje': 'Ingrese Apellido.'};
    }
    if (telefono.isEmpty) {
      return {'ok': false, 'mensaje': 'Ingrese Telefono.'};
    }
    if (nroDocumento.isEmpty) {
      return {'ok': false, 'mensaje': 'Ingrese Nro Documento.'};
    }
    if (correo.isEmpty) {
      return {'ok': false, 'mensaje': 'Ingrese Correo.'};
    }
    return null;
  }

  Future<Map<String, dynamic>> register() async {
    final tipoDocumento = tipoDocumentoController.value;
    final sector = sectorController.value;
    final nombre = nombreTextController.text;
    final apellido = apellidoTextController.text;
    final correo = correoTextController.text;
    final numeroDocumento = nroDocumentoTextController.text;
    final telefono = telefonoTextController.text;

    registerState(RegisterState.loading);
    final registerResponse = await apiRepository.getRegister({
      'apellido': apellido,
      'nombre': nombre,
      'correo': correo,
      'numeroDocumento': numeroDocumento,
      'tipoDocumento': tipoDocumento,
      'sector': sector,
      'telefono': telefono,
    });

    if (registerResponse.statusCode == 200) {
      //final userReponse = usuarioFromJson(registerResponse.body);
      //await localRepository.insertUsuario(userReponse);
      registerState(RegisterState.initial);
      return {'ok': true};
    } else {
      final error = badResponseFromJson(registerResponse.body);
      final descripcion = StringBuffer();
      for (final it in error.errores) {
        descripcion.write('$it\n');
      }
      registerState(RegisterState.initial);
      return {'ok': false, 'mensaje': descripcion.toString()};
    }
  }
}
