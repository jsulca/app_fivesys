import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_fivesys/ui/pages/auditorias/auditoria_controller.dart';

class ItemsButton {
  ItemsButton({
    required this.icon,
    required this.onPressed,
    required this.title,
  });
  final String icon;
  final String title;
  final Function onPressed;
}

class CustomMenuAuditoria extends StatelessWidget {
  const CustomMenuAuditoria({
    Key? key,
    this.mostrar = true,
    required this.backgroundColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.items,
    required this.controller,
  }) : super(key: key);
  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<ItemsButton> items;
  final AuditoriaController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: mostrar ? 1 : 0,
      child: Visibility(
        visible: mostrar,
        child: _CustomMenuBackground(
          color: backgroundColor,
          child: _MenuItems(items, activeColor, inactiveColor, controller),
        ),
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  const _MenuItems(
    this.menuItems,
    this.activeColor,
    this.inactiveColor,
    this.controller,
  );
  final List<ItemsButton> menuItems;
  final Color activeColor;
  final Color inactiveColor;
  final AuditoriaController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (i) => _CustomMenuButton(
          index: i,
          item: menuItems[i],
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          controller: controller,
        ),
      ),
    );
  }
}

class _CustomMenuBackground extends StatelessWidget {
  const _CustomMenuBackground({
    required this.child,
    required this.color,
  });
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Container(
      width: size * 0.9,
      height: 60,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              spreadRadius: -5,
            )
          ]),
      child: child,
    );
  }
}

class _CustomMenuButton extends StatelessWidget {
  const _CustomMenuButton({
    required this.index,
    required this.item,
    required this.activeColor,
    required this.inactiveColor,
    required this.controller,
  });
  final int index;
  final ItemsButton item;
  final Color activeColor;
  final Color inactiveColor;
  final AuditoriaController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.changeItemSeleccionado(index);
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                item.icon,
                color: (controller.itemSeleccionado.value == index)
                    ? activeColor
                    : inactiveColor,
                height: (controller.itemSeleccionado.value == index) ? 35 : 24,
                width: (controller.itemSeleccionado.value == index) ? 35 : 24,
              ),
              Text(
                item.title,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: (controller.itemSeleccionado.value == index)
                        ? activeColor
                        : inactiveColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
