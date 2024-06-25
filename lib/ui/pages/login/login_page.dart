import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/background.dart';
import 'components/bottomsheet_change_pass.dart';
import 'login_controller.dart';

import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:app_fivesys/helpers/util.dart';

import 'package:app_fivesys/ui/widget/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  final controller = Get.find<LoginController>();
  late AnimationController animationController;
  bool isPassword = true;

  @override
  void initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = kDefaultTime;
  }

  Future<void> login(BuildContext context, Size size, bool darkTheme) async {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    final validation = await controller.validateLogin();
    if (validation != null) {
      final descripcion = validation['mensaje'].toString();
      showSnackBar(descripcion, context);
      return;
    }

    dialogLoad(context, 'Iniciando Sesión...', darkTheme);

    final result = await controller.login();
    Navigator.pop(context);

    if (result['pass'] == true) {
      getChangePass(context, size, darkTheme);
      return;
    }

    if (result['ok'] == true) {
      Get.offAllNamed(AppRoutes.home);
      return;
    }

    final descripcion = result['mensaje'].toString();
    showSnackBar(descripcion, context);
  }

  void getChangePass(BuildContext context, Size size, bool darkTheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: animationController,
      builder: (context) => BottomSheetChangePass(
        darkTheme: darkTheme,
        loginController: controller,
      ),
    );
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
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Five SYS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkTheme ? kWhiteColor : kPrimaryColor,
                          fontSize: 26),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  // CustomDropDown<TipoDocumento>(
                  //   border: Border.all(
                  //       color: darkTheme ? Colors.white30 : Colors.black26),
                  //   icon: Icons.description_outlined,
                  //   lista: tipoDocumentos,
                  //   value: controller.tipoDocumentoController.value,
                  //   darkTheme: darkTheme,
                  //   onChanged: (value) => controller.updateTipoDocumento(value),
                  //   margin: const EdgeInsets.symmetric(
                  //       horizontal: kDefaultPadding * 2),
                  // ),
                  // const SizedBox(height: kDefaultPadding * 0.5),
                  CustomInput(
                    icon: Icons.account_circle,
                    hintText: 'Correo',
                    controller: controller.usernameTextController,
                    textInputAction: TextInputAction.next,
                    darkTheme: darkTheme,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.5),
                  CustomInput(
                    icon: Icons.lock_clock_outlined,
                    hintText: 'Contraseña',
                    controller: controller.passwordTextController,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    isPasswordVisible: isPassword,
                    textInputAction: TextInputAction.done,
                    darkTheme: darkTheme,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                    onPressPassword: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  const SizedBox(height: kDefaultPadding * 0.5),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                    child: Row(
                      children: [
                        /*  TextButton(
                          onPressed: () => Get.toNamed('register'),
                          child: const Text('Registrate'),
                        ), */
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => login(context, size, darkTheme),
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
                              "INGRESAR",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 0.7),
                  Text(
                    'Alphamanufacturas S.A.C',
                    style: TextStyle(
                        color: darkTheme
                            ? kWhiteColor
                            : kBlackColor.withOpacity(0.3)),
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
