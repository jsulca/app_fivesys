import 'package:app_fivesys/helpers/util.dart';
import 'package:flutter/material.dart';

class BottomSheetInformation extends StatelessWidget {
  const BottomSheetInformation({
    Key? key,
    required this.darkTheme,
  }) : super(key: key);

  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkTheme ? kDarkColor : kWhiteColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(80),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información',
              style: TextStyle(
                fontSize: kDefaultPadding,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 0.4,
            ),
            const Text(
              'Los interesados en la versión completa deben de comunicarse al teléfono : +51 01 5253555, o escribir al correo fivesys@alphamanufacturas.com',
              overflow: TextOverflow.clip,
            ),
            const SizedBox(
              height: kDefaultPadding * 0.4,
            ),
            const Text(
                'Mas información a www.alphamanufacturas.com o al fanpage: FiveSys'),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Entiendo'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
