import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/domain/models/auditoria.dart';

class CardViewObservaciones extends StatelessWidget {
  const CardViewObservaciones({
    Key? key,
    required this.detalle,
    required this.darkTheme,
    required this.onPressPhoto,
    required this.onPress,
    this.enabled = false,
    required this.token,
  }) : super(key: key);
  final Detalle detalle;
  final bool darkTheme;
  final VoidCallback? onPressPhoto;
  final ValueChanged<Menu>? onPress;
  final bool enabled;
  final String token;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = TextStyle(
      color: darkTheme ? kWhiteColor : kPrimaryDarkColor,
    );
    final iconColor = darkTheme ? kWhiteColor : kPrimaryDarkColor;
    return Container(
      margin: const EdgeInsets.all(kDefaultPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: kAccentColor,
          width: 1.2,
          style: BorderStyle.solid,
        ),
        color: darkTheme ? kDarkColor : kWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detalle.path.isEmpty) ...{
            if (detalle.fotoId == null || detalle.fotoId == 0) ...{
              noImagen(size)
            } else ...{
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding),
                  topRight: Radius.circular(kDefaultPadding),
                ),
                child: FadeInImage(
                  image: NetworkImage(
                    '$urlPhoto${detalle.fotoId}',
                    headers: {'Authorization': 'Bearer $token'},
                  ),
                  placeholder: const AssetImage('assets/gif/load.gif'),
                  width: size.width,
                  height: kDefaultPadding * 10,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) {
                    return noImagen(size);
                  },
                ),
              )
            }
          } else ...{
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding),
                topRight: Radius.circular(kDefaultPadding),
              ),
              child: Image.file(
                File(detalle.path),
                width: size.width,
                height: kDefaultPadding * 10,
                fit: BoxFit.cover,
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                ) {
                  return noImagen(size);
                },
              ),
            )
          },
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.supervisor_account, color: iconColor),
                          const SizedBox(width: kDefaultPadding / 4),
                          Text(
                            detalle.categoria?.nombre ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      color: darkTheme ? kDarkColor : kWhiteColor,
                      itemBuilder: (BuildContext context) => const [
                        PopupMenuItem<Menu>(
                          value: Menu.edit,
                          child: Text('Editar'),
                        ),
                        PopupMenuItem<Menu>(
                          value: Menu.delete,
                          child: Text('Eliminar'),
                        ),
                      ],
                      enabled: !enabled,
                      onSelected: onPress,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.supervisor_account, color: iconColor),
                    const SizedBox(width: kDefaultPadding / 4),
                    Text(
                      detalle.componente?.nombre ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: textStyle,
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    Icon(Icons.date_range, color: iconColor),
                    const SizedBox(width: kDefaultPadding / 4),
                    Text(
                      detalle.aspectoObservado ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: textStyle,
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    const SizedBox(width: kDefaultPadding / 4),
                    Text(
                      detalle.nombre ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle,
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: Text(
                        detalle.detalle ?? '',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding / 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('S1: ${detalle.s1}', style: textStyle),
                      Text('S2: ${detalle.s2}', style: textStyle),
                      Text('S3: ${detalle.s3}', style: textStyle),
                      Text('S4: ${detalle.s4}', style: textStyle),
                      Text('S5: ${detalle.s5}', style: textStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum Menu {
  edit,
  delete,
}
