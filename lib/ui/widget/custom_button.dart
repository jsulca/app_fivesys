import 'package:flutter/material.dart';
import 'package:app_fivesys/helpers/util.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final IconData? iconData;
  final bool darkTheme;
  final bool isLoad;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    required this.title,
    this.onPress,
    this.iconData,
    this.darkTheme = false,
    this.width,
    this.height,
    this.isLoad = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoad ? null : onPress,
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        textStyle: const TextStyle(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(1),
      ),
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.infinity,
        height: height ?? 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            gradient: LinearGradient(colors: gradients)),
        padding: const EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) ...{
              Icon(
                iconData,
                color: kWhiteColor,
              ),
              const SizedBox(width: 5)
            },
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (isLoad) ...{
              const SizedBox(width: 10),
              CircularProgressIndicator(
                backgroundColor: darkTheme ? kPrimaryColor : kAccentColor,
              )
            }
          ],
        ),
      ),
    );
    /*   return InkWell(
      onTap: onPress,
      child: Container(
        decoration: getThemeBoxDecoration(darkTheme: darkTheme),
        width: width ?? double.infinity,
        height: height ?? 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: darkTheme ? kWhiteColor : null, fontSize: 17),
            ),
            if (iconData != null) ...{
              const SizedBox(width: 10),
              Icon(
                iconData,
                color: darkTheme ? kWhiteColor : kBlackColor,
              )
            }
          ],
        ),
      ),
    ); */
  }
}
