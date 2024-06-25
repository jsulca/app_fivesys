import 'package:app_fivesys/helpers/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/ui/pages/auditorias/auditoria_controller.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/cardview_puntosfijos.dart';

class AuditoriaForm3Page extends StatefulWidget {
  const AuditoriaForm3Page(
      this.auditoriaId, this.estado, this.isOnline, this.token,
      {Key? key})
      : super(key: key);
  final int auditoriaId;
  final int estado;
  final bool isOnline;
  final String token;

  @override
  State<AuditoriaForm3Page> createState() => _AuditoriaForm3PageState();
}

class _AuditoriaForm3PageState extends State<AuditoriaForm3Page> {
  ScrollController controller = ScrollController();
  final auditoriaController = Get.find<AuditoriaController>();
  double scrollAnterior = 0;

  @override
  void initState() {
    auditoriaController.getPuntosFijosById(widget.auditoriaId);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final darkTheme = auditoriaController.darkTheme.value;
        return CustomScrollView(
          controller: controller,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final puntoFijo = auditoriaController.puntosFijos[i];
                  return CardViewPuntosFijos(
                      punto: puntoFijo,
                      darkTheme: darkTheme,
                      enabled: widget.estado != 1,
                      onPress: (value) {
                        if (Menu.camera == value) {
                          _getCamera(i, puntoFijo);
                        } else {
                          _getFiles(i, puntoFijo);
                        }
                      },
                      onPressPhoto: () {},
                      token: widget.token);
                },
                childCount: auditoriaController.puntosFijos.length,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getFiles(int index, PuntoFijo p) async {
    try {
      final result = await permission();
      if (!result) {
        return;
      }
      final List<PlatformFile>? _paths = (await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      ))
          ?.files;
      if (_paths != null) {
        await auditoriaController.saveFilesPuntoFijo(_paths, p, index);
      } else {
        logException('No selecciono ningún archivo.');
      }
    } on PlatformException catch (e) {
      logException('Unsupported operation$e');
    } catch (e) {
      logException(e.toString());
    }
  }

  Future<void> _getCamera(int index, PuntoFijo p) async {
    try {
      final result = await permission();
      if (!result) {
        return;
      }
      final _pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );
      if (_pickedFile != null) {
        await auditoriaController.saveCameraPuntoFijo(_pickedFile, p, index);
      } else {
        logException('No tomo foto.');
      }
    } catch (e) {
      logException('Unsupported operation$e');
    }
  }
}
