import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/data/repository/api_repository.dart';
import 'package:app_fivesys/data/repository/local_repository.dart';
import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/domain/response/response.dart';

enum LoginState {
  loading,
  initial,
}

class LoginController extends GetxController {
  final LocalRepository localRepository;
  final ApiRepository apiRepository;

  LoginController({
    required this.localRepository,
    required this.apiRepository,
  });

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  Rx<TipoDocumento> tipoDocumentoController =
      TipoDocumento(id: 3, nombre: 'L.E / DNI').obs;
  RxBool darkTheme = false.obs;

  //Cambio de Pass
  final newPassController = TextEditingController();
  final repeatNewPassController = TextEditingController();

  @override
  void onInit() {
    validateTheme();
    super.onInit();
  }

  Future<void> validateTheme() async {
    final dark = await localRepository.isDarkMode();
    darkTheme(dark);
  }

  Rx<LoginState> loginState = LoginState.initial.obs;
  Rx<LoginState> statePass = LoginState.initial.obs;

  void updateTipoDocumento(TipoDocumento? value) {
    tipoDocumentoController(value);
  }

  Future<Map<String, dynamic>?> validateLogin() async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    if (username.isEmpty) {
      return {'ok': false, 'mensaje': 'Digite el correo.'};
    }

    if (password.isEmpty) {
      return {'ok': false, 'mensaje': 'Digite la contraseña.'};
    }

    return null;
  }

  Future<Map<String, dynamic>> login() async {
    // final tipoDocumento = tipoDocumentoController.value;
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    loginState(LoginState.loading);
    final loginResponse = await apiRepository.getLogin({
      // "TipoDocumentoId": tipoDocumento.id.toString(),
      "correo": username,
      "clave": password
    });

    try {
      if (loginResponse.statusCode == 200) {
        final userReponse = usuarioFromJson(loginResponse.body);
        await localRepository.insertUsuario(userReponse);

        loginState(LoginState.initial);
        final result = userReponse.cambiarClave;
        return result == true ? {'pass': true} : {'pass': false, 'ok': true};
      }

      final error = badResponseFromJson(loginResponse.body);
      final descripcion = StringBuffer();
      for (final it in error.errores) {
        descripcion.write('$it\n');
      }

      loginState(LoginState.initial);
      return {'ok': false, 'mensaje': descripcion.toString()};
    } catch (e) {
      return {'ok': false, 'mensaje': 'Error: ${loginResponse.statusCode}'};
    }
  }

  void clearPass() {
    newPassController.clear();
    repeatNewPassController.clear();
  }

  Future<Map<String, dynamic>> validateChangePass() async {
    final newPass = newPassController.text;
    final repeatPass = repeatNewPassController.text;

    if (newPass.isEmpty) {
      return {'ok': false, 'message': 'Ingrese nueva contraseña.'};
    }

    if (newPass != repeatPass) {
      return {'ok': false, 'message': 'Las contraseñas deben coincidir.'};
    }

    return sendChangePass(newPass, repeatPass);
  }

  Future<Map<String, dynamic>> sendChangePass(
      String pass, String repeatPass) async {
    statePass(LoginState.loading);

    final usuario = await localRepository.getExistUsuario();

    final passResponse = await apiRepository.changePass(usuario?.token ?? '', {
      'nuevaClave': pass,
      'confirmacionClave': repeatPass,
    });

    if (passResponse.statusCode == 200) {
      final userReponse = usuarioFromJson(passResponse.body);
      await localRepository.updateUsuario(userReponse);
      statePass(LoginState.initial);
      return {'result': true, 'message': passResponse.body};
    }

    if (passResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(passResponse.body);
      return {
        'result': false,
        'message': '${unauthorized.status}\nNo autorizado'
      };
    }

    final error = badResponseFromJson(passResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }
    statePass(LoginState.initial);
    return {'result': false, 'message': descripcion.toString()};
  }
}
