import 'package:flutter/material.dart';
import 'package:app_fivesys/helpers/util.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    this.value,
    this.hint,
    this.darkTheme = false,
    this.icon,
    required this.lista,
    this.onChanged,
    this.background,
    this.margin,
    this.border,
    this.width,
    this.isTitle = false,
    this.title,
    this.enabled = false,
  }) : super(key: key);

  final T? value;
  final Widget? hint;
  final bool darkTheme;
  final IconData? icon;
  final List<T> lista;
  final ValueChanged<T?>? onChanged;
  final Color? background;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final double? width;
  final String? title;
  final bool isTitle;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return isTitle ? _dropDownTitle() : _dropDown();
  }

  Widget _dropDown() {
    return Container(
      height: 55,
      width: width ?? double.infinity,
      margin: margin,
      decoration: BoxDecoration(
          color: background ?? (darkTheme ? kDarkColor : kPrimaryLightColor),
          borderRadius: BorderRadius.circular(25),
          border: border,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: Row(
        children: <Widget>[
          if (icon != null) ...{
            const SizedBox(width: kDefaultPadding / 2),
            Icon(icon, color: darkTheme ? kWhiteColor : kPrimaryColor),
          },
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButton<T>(
              hint: hint,
              isExpanded: true,
              underline: const SizedBox(),
              icon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.arrow_drop_down,
                    color: darkTheme ? kWhiteColor : kPrimaryColor),
              ),
              items: lista.map((T data) {
                return DropdownMenuItem<T>(
                  value: data,
                  child: Text(data.toString()),
                );
              }).toList(),
              value: getSelectedValue(value),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropDownTitle() {
    return Container(
      height: 55,
      width: width ?? double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        color: background ?? (darkTheme ? kDarkColor : kPrimaryLightColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: <Widget>[
          if (icon != null) ...{
            Icon(icon, color: darkTheme ? kWhiteColor : kPrimaryColor),
            const SizedBox(width: kDefaultPadding / 2),
          },
          Expanded(
            child: DropdownButtonFormField<T>(
              hint: hint,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down,
                  color: darkTheme ? kWhiteColor : kPrimaryColor),
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kDefaultPadding)),
                labelText: title,
              ),
              items: lista.map((T data) {
                return DropdownMenuItem<T>(
                  value: data,
                  child: Text(data.toString()),
                );
              }).toList(),
              value: getSelectedValue(value),
              onChanged: enabled ? null : onChanged,
            ),
          ),
        ],
      ),
    );
  }

  T? getSelectedValue(T? yourValue) {
    if (yourValue == null) return null;
    final data = lista.where((e) => e.toString() == yourValue.toString());
    return data.isNotEmpty ? data.first : null;
  }
}
