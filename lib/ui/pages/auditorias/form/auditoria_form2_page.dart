import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auditoria_detalle_page.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/auditorias/auditoria_controller.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/cardview_observaciones.dart';

class AuditoriaForm2Page extends StatefulWidget {
  const AuditoriaForm2Page(
      this.auditoriaId, this.estado, this.isOnline, this.token,
      {Key? key})
      : super(key: key);
  final int auditoriaId;
  final int estado;
  final bool isOnline;
  final String token;

  @override
  State<AuditoriaForm2Page> createState() => _AuditoriaForm2PageState();
}

class _AuditoriaForm2PageState extends State<AuditoriaForm2Page> {
  final controller = ScrollController();
  final auditoriaController = Get.find<AuditoriaController>();
  var scrollAnterior = 0.0;

  @override
  void initState() {
    auditoriaController.getDetallesById(widget.auditoriaId);

    controller.addListener(() {
      if (controller.offset > scrollAnterior && controller.offset > 50) {
        auditoriaController.changeMostrar(isChange: false);
      } else {
        auditoriaController.changeMostrar(isChange: true);
      }
      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final darkTheme = auditoriaController.darkTheme.value;
          return CustomScrollView(
            controller: controller,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final detalle = auditoriaController.detalles[index];
                    return CardViewObservaciones(
                      detalle: detalle,
                      darkTheme: darkTheme,
                      onPress: (value) {
                        if (Menu.edit == value) {
                          startAuditoriaDetalle(
                              detalle.auditoriaId, detalle.id, index);
                        } else {
                          confirmDelete(detalle);
                        }
                      },
                      onPressPhoto: () {},
                      enabled: widget.estado != 1,
                      token: widget.token,
                    );
                  },
                  childCount: auditoriaController.detalles.length,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: Padding(
          padding: EdgeInsets.only(
            top: (widget.isOnline) ? kDefaultPadding * 2 : 0,
            left: kDefaultPadding + 5,
            right: (widget.isOnline) ? kDefaultPadding / 2 : 5,
          ),
          child: FloatingActionButton(
              heroTag: "fab2",
              child: const Icon(Icons.add),
              onPressed: () => widget.isOnline
                  ? widget.estado == 0 || widget.estado == 1
                      ? startAuditoriaDetalle(widget.auditoriaId, 0, -1)
                      : showSnackBar('Inhabilitado para editar', context)
                  : widget.estado == 1
                      ? startAuditoriaDetalle(widget.auditoriaId, 0, -1)
                      : showSnackBar('Inhabilitado', context)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Future<void> startAuditoriaDetalle(
      int auditoriaId, int detalleId, int index) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: AuditoriaDetallePage(
              auditoriaId: auditoriaId,
              detalleId: detalleId,
              index: index,
              token: widget.token,
            ),
          );
        },
      ),
    );
  }

  void confirmDelete(Detalle detalle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mensaje'),
        content: const Text('Desea eliminar el detalle ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              auditoriaController.deleteDetalle(detalle.id);
              Navigator.of(context).pop(true);
            },
            child: const Text('Si'),
          ),
        ],
      ),
    );
  }
}
