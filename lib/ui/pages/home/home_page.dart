import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

import 'package:app_fivesys/helpers/util.dart';

import 'package:app_fivesys/ui/pages/auditorias/auditoria_page.dart';
import 'package:app_fivesys/ui/pages/home/components/custom_menu.dart';
import 'package:app_fivesys/ui/pages/home/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final homeController = Get.find<HomeController>();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      animationDuration: kDefaultTime,
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   onWillPop: () async {
    //     if (_tabController.index != 0) {
    //       _tabController.index = 0;
    //       homeController.changeItemSeleccionado(0);
    //       return false;
    //     }
    //     return true;
    //   },
    return PopScope(
      canPop: true,
      onPopInvoked: (bool canPop) async {
        if (_tabController.index != 0) {
          _tabController.index = 0;
          homeController.changeItemSeleccionado(0);
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                //ReportePage(),
                AuditoriaPage(),
                ProfilePage(),
              ],
            ),
            menuPage(_tabController, homeController),
          ],
        ),
      ),
    );
  }

  Widget menuPage(TabController pageController, HomeController homeController) {
    return Positioned(
      bottom: kDefaultPadding / 2,
      child: Obx(
        () {
          final darkTheme = homeController.darkTheme.value;
          return CustomMenu(
            mostrar: homeController.mostrar.value,
            backgroundColor: darkTheme ? kDarkColor : kPrimaryColor,
            activeColor: kAccentColor,
            inactiveColor: darkTheme ? kWhiteColor : kWhiteColor,
            items: [
              /* ItemsButton(
                icon: 'assets/icon/ic_donut.svg',
                title: "Principal",
                onPressed: () {
                  pageController.animateTo(0,
                      duration: kDefaultTime, curve: Curves.ease);
                },
              ), */
              ItemsButton(
                icon: 'assets/icon/ic_auditorias.svg',
                title: "Auditorias",
                onPressed: () {
                  pageController.animateTo(0,
                      duration: kDefaultTime, curve: Curves.ease);
                },
              ),
              ItemsButton(
                icon: 'assets/icon/ic_info.svg',
                title: "Info",
                onPressed: () {
                  pageController.animateTo(1,
                      duration: kDefaultTime, curve: Curves.ease);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
