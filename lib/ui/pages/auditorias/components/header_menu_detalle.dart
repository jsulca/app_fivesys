import 'package:flutter/material.dart';

import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/auditorias/auditoria_controller.dart';

const _minHeaderExtent = 60.0;

class HeaderMenuDetalle extends SliverPersistentHeaderDelegate {
  HeaderMenuDetalle({
    required this.darkTheme,
    required this.auditoriaController,
  });
  final bool darkTheme;
  final AuditoriaController auditoriaController;

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
            const Padding(
              padding: EdgeInsets.only(
                  top: kDefaultPadding * 0.95, left: kDefaultPadding * 0.4),
              child: Text(
                'Observación',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
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
}
