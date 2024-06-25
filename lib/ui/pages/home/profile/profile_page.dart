import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';
import 'package:app_fivesys/ui/pages/home/profile/bottom_information.page.dart';
import 'package:app_fivesys/ui/widget/custom_loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  final controller = Get.find<HomeController>();
  late AnimationController animationController;
  double scrollAnterior = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset > scrollAnterior &&
          scrollController.offset > 20) {
        controller.changeMostrar(isChange: false);
      } else {
        controller.changeMostrar(isChange: true);
      }

      scrollAnterior = scrollController.offset;
    });
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = kDefaultTime;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          final darkTheme = controller.darkTheme.value;
          //final onlineMode = controller.onlineMode.value;

          return Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding / 2),
                        child: Row(
                          children: [
                            Image.asset('assets/image/logo.png'),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    ProfileMenu(
                      text: controller.usuario.value.nombreCompleto,
                      icon: 'assets/icon/ic_manage_accounts.svg',
                      press: () => {},
                      darkTheme: darkTheme,
                    ),
                    // ProfileMenu(
                    //   text: 'Modo en linea',
                    //   icon: 'assets/icon/ic_setting.svg',
                    //   press: () => confirmDialog(context, size, !onlineMode),
                    //   onChanged: (value) => confirmDialog(context, size, value),
                    //   isSwitch: true,
                    //   value: onlineMode,
                    //   darkTheme: darkTheme,
                    // ),
                    ProfileMenu(
                      text: 'Información',
                      icon: 'assets/icon/ic_manage_accounts.svg',
                      press: () => getInformacion(size, darkTheme),
                      darkTheme: darkTheme,
                    ),
                    ProfileMenu(
                      text: 'Modo Oscuro',
                      icon: 'assets/icon/ic_setting.svg',
                      press: () => controller.onThemeUpdated(theme: !darkTheme),
                      onChanged: (value) =>
                          controller.onThemeUpdated(theme: value),
                      value: darkTheme,
                      isSwitch: true,
                      darkTheme: darkTheme,
                    ),
                    ProfileMenu(
                      text: 'Cerrar Sesión',
                      icon: 'assets/icon/ic_logout.svg',
                      press: () => logout(),
                      darkTheme: darkTheme,
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: (controller.state.value == HomeState.loading)
                    ? const CustomLoading()
                    : const SizedBox.shrink(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Future<void> logout() async {
    await controller.logOut();
    Get.offAllNamed(AppRoutes.login);
  }

  void getInformacion(Size size, bool darkTheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: animationController,
      builder: (context) => BottomSheetInformation(darkTheme: darkTheme),
    );
  }

  void confirmDialog(BuildContext context, Size size, bool online) {
    final title = online ? 'Modo Online' : 'Modo Off-line';
    final content = online
        ? 'Deseas cambiar a modo online?\nSi cuentas con auditorias off-line se enviaran estas seguro?'
        : 'Deseas cambiar a modo offline?';

    final alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Si'),
          onPressed: () {
            if (online) {
              controller.changeOnline();
            } else {
              controller.changeOffline();
            }
            Navigator.of(context).pop(true);
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: const [
          Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/image/stevejobs.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.darkTheme,
    this.press,
    this.isSwitch = false,
    this.value = false,
    this.onChanged,
  }) : super(key: key);

  final String text;
  final String icon;
  final VoidCallback? press;
  final bool isSwitch;
  final bool darkTheme;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: darkTheme ? kWhiteColor : kBlackColor,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: darkTheme ? kDarkColor : kPrimaryLightColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: darkTheme ? kAccentColor : kPrimaryColor,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            if (isSwitch)
              Switch(
                value: value,
                onChanged: onChanged,
              )
          ],
        ),
      ),
    );
  }
}
