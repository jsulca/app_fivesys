import 'dart:io';
import 'package:app_fivesys/ui/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/widget/custom_floating_button.dart';
import 'package:app_fivesys/ui/pages/auditorias/components/header_menu_detalle.dart';
import 'package:app_fivesys/ui/pages/auditorias/auditoria_controller.dart';
import 'package:app_fivesys/ui/widget/custom_dropdown.dart';

class AuditoriaDetallePage extends StatefulWidget {
  const AuditoriaDetallePage({
    Key? key,
    required this.auditoriaId,
    required this.detalleId,
    required this.index,
    required this.token,
  }) : super(key: key);

  final int auditoriaId;
  final int detalleId;
  final int index;
  final String token;

  @override
  State<AuditoriaDetallePage> createState() => _AuditoriaDetallePageState();
}

class _AuditoriaDetallePageState extends State<AuditoriaDetallePage> {
  final auditoriaController = Get.find<AuditoriaController>();

  @override
  void initState() {
    auditoriaController.getDetalleById(widget.detalleId, widget.auditoriaId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Obx(() {
              final detalle = auditoriaController.detalle.value;
              final darkTheme = auditoriaController.darkTheme.value;
              return CustomScrollView(slivers: [
                SliverPersistentHeader(
                  delegate: HeaderMenuDetalle(
                    darkTheme: darkTheme,
                    auditoriaController: auditoriaController,
                  ),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => formDetalle(darkTheme, detalle, size),
                    childCount: 1,
                  ),
                )
              ]);
            }),
          ),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: ExpandableFab(
          distance: 112.0,
          children: [
            ActionButton(
              onPressed: () => _getCamera(),
              icon: const Icon(Icons.camera_alt),
            ),
            ActionButton(
              onPressed: () => _getFiles(),
              icon: const Icon(Icons.attach_file),
            ),
            ActionButton(
              onPressed: () => validateDetalle(widget.index),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }

  Widget formDetalle(bool darkTheme, Detalle? detalle, Size size) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Categoria
          const SizedBox(height: kDefaultPadding / 2),
          CustomDropDown<CategoriaElement>(
            background: darkTheme ? kDarkColor : kWhiteColor,
            border: Border.all(
              color: darkTheme ? Colors.white30 : Colors.black26,
            ),
            darkTheme: darkTheme,
            isTitle: true,
            lista: auditoriaController.categorias,
            onChanged: (value) => auditoriaController.updateCategoria(value),
            title: 'Categoria',
            value: auditoriaController.categoriaIndex.value,
          ),
          //Componentes
          const SizedBox(height: kDefaultPadding / 2),
          CustomDropDown<ComponenteElement>(
            background: darkTheme ? kDarkColor : kWhiteColor,
            border: Border.all(
              color: darkTheme ? Colors.white30 : Colors.black26,
            ),
            darkTheme: darkTheme,
            isTitle: true,
            lista: auditoriaController.componentes,
            onChanged: (value) => auditoriaController.updateComponente(value),
            title: 'Componentes',
            value: auditoriaController.componenteIndex.value,
          ),
          //Referencia
          const SizedBox(height: kDefaultPadding / 2),
          CustomInput(
            background: darkTheme ? null : kWhiteColor,
            hintText: 'Referencia',
            controller: auditoriaController.referenciaController,
            darkTheme: darkTheme,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            onChanged: (value) => auditoriaController.updateReferencia(),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          ),
          //Aspecto Observado
          const SizedBox(height: kDefaultPadding / 2),
          CustomInput(
            background: darkTheme ? null : kWhiteColor,
            hintText: 'Aspecto Observado',
            controller: auditoriaController.aspectoObservacionController,
            darkTheme: darkTheme,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            onChanged: (value) => auditoriaController.updateAspectoObservado(),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: [
              CustomDropDown<String>(
                background: darkTheme ? null : kWhiteColor,
                border: Border.all(
                  color: darkTheme ? Colors.white30 : Colors.black26,
                ),
                darkTheme: darkTheme,
                lista: auditoriaController.configuracionNames,
                value: auditoriaController.configuracion.value,
                onChanged: (value) =>
                    auditoriaController.updateConfiguracion(value),
                width: 100,
              ),
              const SizedBox(width: kDefaultPadding / 5),
              Flexible(
                child: CustomDropDown<ConfiguracionCombo>(
                  background: darkTheme ? null : kWhiteColor,
                  border: Border.all(
                    color: darkTheme ? Colors.white30 : Colors.black26,
                  ),
                  darkTheme: darkTheme,
                  lista: auditoriaController.configuracionValues,
                  onChanged: (value) =>
                      auditoriaController.updateConfiguracionCombo(value),
                  value: auditoriaController.configuracionIndex.value,
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),
          CustomInput(
            background: darkTheme ? null : kWhiteColor,
            hintText: 'Detalle',
            controller: auditoriaController.detalleController,
            darkTheme: darkTheme,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.newline,
            onChanged: (value) => auditoriaController.updateDetalle(),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            maxLines: 4,
          ),
          if (detalle?.auditoriaDetallePadreId != null) ...{
            const SizedBox(height: kDefaultPadding / 2),
            Row(
              children: [
                Checkbox(
                    value: detalle?.finalizado,
                    onChanged: (value) =>
                        auditoriaController.updateFinalizado(value)),
                const Text('¿DESEAS FINALIZAR LA OBSERVACIÓN?')
              ],
            ),
          },
          const SizedBox(height: kDefaultPadding / 2),
          if (detalle != null) ...{
            if (detalle.path.isEmpty) ...{
              if (detalle.fotoId == null || detalle.fotoId == 0) ...{
                noImagenDetalle(size)
              } else ...{
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(kDefaultPadding),
                  ),
                  child: FadeInImage(
                    image: NetworkImage(
                      '$urlPhoto${detalle.fotoId}',
                      headers: {'Authorization': 'Bearer ${widget.token}'},
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
                      return noImagenDetalle(size);
                    },
                  ),
                )
              }
            } else ...{
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(kDefaultPadding),
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
                    return noImagenDetalle(size);
                  },
                ),
              )
            },
            if (detalle.auditoriaDetallePadreFotoId != null) ...{
              const SizedBox(height: kDefaultPadding / 2),
              const Text(
                'Foto Anterior',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              (detalle.pathPadre.isEmpty)
                  ? fotoAnteriorOnline(detalle, size)
                  : fotoAnteriorOffline(detalle, size)
            },
          } else ...{
            noImagenDetalle(size)
          },
        ],
      ),
    );
  }

  Widget fotoAnteriorOffline(Detalle detalle, Size size) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(kDefaultPadding),
      ),
      child: Image.file(
        File(detalle.pathPadre),
        width: size.width,
        height: kDefaultPadding * 10,
        fit: BoxFit.cover,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
        ) {
          return noImagenDetalle(size);
        },
      ),
    );
  }

  Widget fotoAnteriorOnline(Detalle detalle, Size size) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(kDefaultPadding),
      ),
      child: FadeInImage(
        image: NetworkImage(
          '$urlPhoto${detalle.auditoriaDetallePadreFotoId}',
          headers: {'Authorization': 'Bearer ${widget.token}'},
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
          return noImagenDetalle(size);
        },
      ),
    );
  }

  void validateDetalle(int index) async {
    final mensaje = await auditoriaController.validateDetalle(index);

    if (mensaje.isNotEmpty) {
      logException(mensaje);
      return;
    }

    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mensaje'),
        content: const Text('Se eliminaran los cambios'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Entiendo'),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  Future<void> _getFiles() async {
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
        await auditoriaController.saveFilesDetalle(_paths);
      } else {
        logException('No selecciono ningún archivo.');
      }
    } on PlatformException catch (e) {
      logException('Unsupported operation$e');
    } catch (e) {
      logException(e.toString());
    }
  }

  Future<void> _getCamera() async {
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
        await auditoriaController.saveCameraDetalle(_pickedFile);
      } else {
        logException('No tomo foto.');
      }
    } catch (e) {
      logException('Unsupported operation$e');
    }
  }
}
