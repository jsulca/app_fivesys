import 'package:flutter/material.dart';
import 'package:app_fivesys/helpers/util.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool darkTheme;

  const Background({Key? key, required this.child, required this.darkTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/image/top1.png',
              width: size.width,
              color: kPrimaryColor,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/image/top2.png',
              width: size.width,
              color: kPrimaryColor,
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child:
                Image.asset('assets/image/logo.png', width: size.width * 0.35),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Image.asset(
              'assets/image/bottom.png',
              width: size.width,
              fit: BoxFit.fill,
            ),
          ),
          child
        ],
      ),
    );
  }
}
