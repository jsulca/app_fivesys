import 'package:flutter/material.dart';

import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/bottomsheet_new.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/bottomsheet_filtro.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';

const _minHeaderExtent = 60.0;

class HeaderMenu extends SliverPersistentHeaderDelegate {
  HeaderMenu({
    required this.isOnline,
    required this.darkTheme,
    required this.homeController,
    required this.animationController,
  });
  final bool darkTheme;
  final bool isOnline;
  final HomeController homeController;
  final AnimationController animationController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: darkTheme ? kBlackColor : kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          children: [
            Image.asset('assets/image/logo.png'),
            const Spacer(),
            IconButton(
              onPressed: () => confirmFilter(context, darkTheme, true),
              icon: const Icon(Icons.filter_alt, size: kDefaultPadding * 1.5),
            ),
            IconButton(
              onPressed: () => confirmFilter(context, darkTheme, false),
              icon: const Icon(Icons.add, size: kDefaultPadding * 1.5),
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => _minHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

  void confirmFilter(
      BuildContext context, bool darkTheme, bool isSearch) async {
    if (isOnline) {
      dialogLoad(context, 'Cargando...', darkTheme);
      final result = await homeController.getFiltro(isSearch);
      Navigator.pop(context);
      if (result) {
        showModalBottom(context, isSearch);
      }
    } else {
      await homeController.getFiltroOffline(isSearch);
      showModalBottom(context, isSearch);
    }
  }

  void showModalBottom(context, isSearch) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      transitionAnimationController: animationController,
      builder: (context) => isSearch
          ? BottomSheetFiltro(
              darkTheme: darkTheme,
              homeController: homeController,
              isOnline: isOnline,
            )
          : BottomSheetNew(
              darkTheme: darkTheme,
              homeController: homeController,
              isOnline: isOnline,
            ),
    );
  }
}
