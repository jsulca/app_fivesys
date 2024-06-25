import 'package:flutter/material.dart';

import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/helpers/util.dart';

class CardViewAuditoria extends StatelessWidget {
  const CardViewAuditoria({
    Key? key,
    required this.auditor,
    required this.index,
    required this.darkTheme,
    required this.isOnline,
    required this.onPressEdit,
    required this.onPressEmail,
    required this.onPressPdf,
    required this.onChangedOffline,
  }) : super(key: key);
  final Auditoria auditor;
  final int index;
  final bool darkTheme;
  final bool isOnline;
  final VoidCallback? onPressEdit;
  final VoidCallback? onPressEmail;
  final VoidCallback? onPressPdf;
  final ValueChanged<bool?>? onChangedOffline;

  @override
  Widget build(BuildContext context) {
    final estado = auditor.estado;
    final kBackgroundColor = estado == 0 ? kBlueGreyColor
        : (estado == 1) ? kPendienteColor
        : (estado == 2) ? kAccentColor : kRedColor;
    const bold = TextStyle(fontWeight: FontWeight.bold);

    return Container(
      margin: const EdgeInsets.all(kDefaultPadding / 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: kBackgroundColor,
          width: 1.2,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(kDefaultPadding)),
        color: darkTheme ? kDarkColor : kWhiteColor,
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: kDefaultPadding / 2,
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        auditor.codigo,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: darkTheme ? kWhiteColor : kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      (estado == 0) ? 'EMITIDO'
                          : (estado == 1) ? 'PROGRAMADO'
                          : (estado == 2) ? 'TERMINADO'
                              : 'ANULADO',
                      style: TextStyle(
                        color: kBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: Text(
                        auditor.responsable?.nombreCompleto ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Row(
                  children: [
                    const Icon(Icons.group),
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: Text(
                        auditor.grupo?.nombre ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Row(
                  children: [
                    const Icon(Icons.place),
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: Text(
                        '${auditor.area?.nombre ?? ''} / ${auditor.sector?.nombre ?? ' '}',
                        overflow: TextOverflow.ellipsis,
                        style: bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded),
                    const SizedBox(width: kDefaultPadding / 4),
                    Text(
                      auditor.fechaRegistro ?? '',
                      style: bold,
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Row(
                  children: [
                    const SizedBox(width: kDefaultPadding * 1.5),
                    Text(
                      auditor.nombre,
                      overflow: TextOverflow.ellipsis,
                      style: bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // if (isOnline) ...{
                //   Checkbox(
                //     value: auditor.online == 1,
                //     onChanged: onChangedOffline,
                //   ),
                //   const Text(
                //     'Ver en Offline',
                //     style: bold,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                //   const Spacer(),
                // },
                IconButton(
                  onPressed: onPressEdit,
                  icon: const Icon(Icons.edit),
                ),
                if (isOnline) ...{
                  IconButton(
                    onPressed: onPressPdf,
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                  ),
                },
                if (!isOnline) ...{
                  if (auditor.online == 0) ...{
                    IconButton(
                      onPressed: onPressEmail,
                      icon: Icon(isOnline ? Icons.send : Icons.delete),
                    ),
                  }
                }
              ],
            ),
          )

          /*    Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: darkTheme ? kPrimaryColor : kGreyColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: IconButton(
                      onPressed: onPressEdit,
                      icon: const Icon(Icons.edit, size: kDefaultPadding * 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: kDefaultPadding * 0.1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: darkTheme ? kPrimaryColor : kGreyColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: IconButton(
                      onPressed: onPressEmail,
                      icon: Icon(
                        isOnline ? Icons.send : Icons.delete,
                        size: kDefaultPadding * 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ), */
        ],
      ),
    );
  }
}

/* enum AuditoriaState {
  loading,
  initial,
} */