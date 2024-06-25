import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/helpers/util.dart';

class CardViewPuntosFijos extends StatelessWidget {
  const CardViewPuntosFijos({
    Key? key,
    required this.punto,
    required this.darkTheme,
    required this.onPressPhoto,
    required this.onPress,
    this.enabled = false,
    required this.token,
  }) : super(key: key);

  final PuntoFijo punto;
  final bool darkTheme;
  final VoidCallback? onPressPhoto;
  final ValueChanged<Menu>? onPress;
  final bool enabled;
  final String token;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          if (punto.path.isEmpty) ...{
            if (punto.fotoId == null || punto.fotoId == 0) ...{
              noImagen(size)
            } else ...{
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding),
                  topRight: Radius.circular(kDefaultPadding),
                ),
                child: FadeInImage(
                  image: NetworkImage(
                    '$urlPhoto${punto.fotoId}',
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
                File(punto.path),
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    punto.nPuntoFijo ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: darkTheme ? kWhiteColor : kPrimaryDarkColor,
                    ),
                  ),
                ),
                PopupMenuButton(
                  color: darkTheme ? kDarkColor : kWhiteColor,
                  itemBuilder: (BuildContext context) => const [
                    PopupMenuItem<Menu>(
                      value: Menu.camera,
                      child: Text('Camara'),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.gallery,
                      child: Text('Galeria'),
                    ),
                  ],
                  enabled: !enabled,
                  onSelected: onPress,
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
  camera,
  gallery,
}
