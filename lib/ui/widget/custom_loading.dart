import 'package:flutter/material.dart';
import 'package:app_fivesys/helpers/util.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  /*    with TickerProviderStateMixin {
  late AnimationController motionController;
  late Animation motionAnimation;
  double size = 0.5;

  @override
  void initState() {
    super.initState();

    motionController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
      lowerBound: 0.8,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });

    motionController.addListener(() {
      setState(() {
        size = motionController.value * 1.5;
      });
    });
    // motionController.repeat();
  } 

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const CircularProgressIndicator(
            backgroundColor: kAccentColor,
          ),
          Image.asset(
            'assets/image/logo.png',
            height: 24,
            width: 24,
          ),

          /* ,
          const SizedBox(height: 5),
          const SizedBox(
            child: LinearProgressIndicator(
              backgroundColor: kAccentColor,
            ),
            width: 100,
          ), */
        ],
      ),
    );
    /*
    return Container(
      color: Colors.black38,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: size,
            child: Image.asset(
              'assets/image/logo.png',
            ),
          ),
        ],
      ),
    );*/
  }
}
