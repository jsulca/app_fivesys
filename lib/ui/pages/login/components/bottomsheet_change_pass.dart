import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:app_fivesys/helpers/util.dart';

import 'package:app_fivesys/ui/pages/login/login_controller.dart';
import 'package:app_fivesys/ui/widget/custom_button.dart';
import 'package:app_fivesys/ui/widget/custom_input.dart';

class BottomSheetChangePass extends StatefulWidget {
  const BottomSheetChangePass({
    Key? key,
    required this.darkTheme,
    required this.loginController,
  }) : super(key: key);

  final bool darkTheme;
  final LoginController loginController;

  @override
  State<BottomSheetChangePass> createState() => _BottomSheetChangePassState();
}

class _BottomSheetChangePassState extends State<BottomSheetChangePass> {
  @override
  void initState() {
    widget.loginController.clearPass();
    super.initState();
  }

  void confirmButton(context) async {
    final data = await widget.loginController.validateChangePass();

    if (data['result'] == true) {
      Navigator.pop(context);
      Get.offAllNamed(AppRoutes.home);
      return;
    }
    Get.snackbar(
      'Error',
      data['message'],
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

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
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: kDefaultPadding * 2),
                      const Text(
                        'Cambiar contraseña',
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
                    controller: widget.loginController.newPassController,
                    darkTheme: widget.darkTheme,
                    hintText: 'Nueva contraseña',
                    icon: Icons.lock_clock_rounded,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomInput(
                    controller: widget.loginController.repeatNewPassController,
                    darkTheme: widget.darkTheme,
                    hintText: 'Repita Contraseña',
                    icon: Icons.lock_clock_rounded,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      title: 'Aceptar',
                      onPress: () => widget.loginController.statePass.value ==
                              LoginState.loading
                          ? null
                          : confirmButton(context),
                      darkTheme: widget.darkTheme,
                      width: size.width * 0.4,
                      isLoad: widget.loginController.statePass.value ==
                          LoginState.loading,
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
}
