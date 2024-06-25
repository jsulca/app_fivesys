import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';
import 'package:app_fivesys/ui/widget/custom_button.dart';
import 'package:app_fivesys/ui/widget/custom_input.dart';

class BottomSheetEmail extends StatefulWidget {
  const BottomSheetEmail(
      {Key? key,
      required this.darkTheme,
      required this.homeController,
      required this.auditoriaId})
      : super(key: key);

  final bool darkTheme;
  final HomeController homeController;
  final int auditoriaId;

  @override
  State<BottomSheetEmail> createState() => _BottomSheetEmailState();
}

class _BottomSheetEmailState extends State<BottomSheetEmail> {
  @override
  void initState() {
    widget.homeController.clearEmail();
    super.initState();
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
            topRight: Radius.circular(30),
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
              final isLoad =
                  widget.homeController.state.value == HomeState.loading;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: kDefaultPadding * 2),
                      const Text(
                        'Envio Correo',
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
                    controller: widget.homeController.emailController,
                    darkTheme: widget.darkTheme,
                    hintText: 'Ingrese email',
                    icon: Icons.email,
                    textInputAction: TextInputAction.next,
                    isEnabled: isLoad,
                    onChanged: (value) => widget.homeController.updateCodigo(),
                    onPress: () => isLoad
                        ? FocusScope.of(context).requestFocus(FocusNode())
                        : null,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      title: 'Enviar',
                      onPress: () => confirmEmail(),
                      darkTheme: widget.darkTheme,
                      width: size.width * 0.4,
                      iconData: Icons.send_outlined,
                      isLoad: isLoad,
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

  void confirmEmail() async {
    final data = await widget.homeController.validateEmail(widget.auditoriaId);

    Get.snackbar(
      'Mensaje',
      data['message'],
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );

    if (data['result'] == true) {
      Navigator.pop(context);
    }

    if (data['status'] == 401) {
      await widget.homeController.logOut();
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
