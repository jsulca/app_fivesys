import 'package:flutter/material.dart';
import 'package:app_fivesys/helpers/util.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.hintText,
    this.icon,
    required this.controller,
    required this.darkTheme,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPasswordVisible = false,
    required this.textInputAction,
    this.onPress,
    this.onPressPassword,
    this.onChanged,
    this.isEnabled = false,
    this.padding,
    this.margin,
    this.textCapitalization,
    this.background,
    this.maxLines = 1,
  }) : super(key: key);
  final String hintText;
  final IconData? icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool darkTheme;
  final bool isPassword;
  final bool isPasswordVisible;
  final TextInputAction textInputAction;
  final VoidCallback? onPress;
  final VoidCallback? onPressPassword;
  final ValueChanged<String>? onChanged;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextCapitalization? textCapitalization;
  final Color? background;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: background ?? (darkTheme ? kDarkColor : kPrimaryLightColor),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: darkTheme ? Colors.white30 : Colors.black26,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        autofocus: false,
        autocorrect: false,
        controller: controller,
        enableInteractiveSelection: false,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        enableSuggestions: false,
        decoration: InputDecoration(
            prefixIcon: (icon == null)
                ? null
                : Icon(icon, color: darkTheme ? kWhiteColor : kPrimaryColor),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            labelText: hintText,
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: onPressPassword,
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )
                : null),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: isPasswordVisible,
        onTap: onPress,
        onChanged: onChanged,
        maxLines: maxLines,
        readOnly: isEnabled ? true : false,
        style: TextStyle(color: darkTheme ? kWhiteColor : null),
      ),
    );
  }
}
