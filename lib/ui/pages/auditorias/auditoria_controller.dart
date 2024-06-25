import 'dart:convert';

import 'package:app_fivesys/domain/response/response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:app_fivesys/data/repository/local_repository.dart';
import 'package:app_fivesys/data/repository/api_repository.dart';
import 'package:app_fivesys/helpers/app_navigation.dart';

import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/domain/models/reporte.dart';
import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/helpers/util.dart';

enum AuditoriaState {
  loading,
  initial,
}

class AuditoriaController extends GetxController {
  AuditoriaController({
    required this.localRepository,
    required this.apiRepository,
  });
  final LocalRepository localRepository;
  final ApiRepository apiRepository;

  Rx<Usuario> usuario = Usuario().obs;
  RxInt itemSeleccionado = 0.obs;
  RxBool mostrar = true.obs;
  RxBool darkTheme = false.obs;
  RxBool onlineMode = false.obs;

  RxList<Auditoria> auditorias = <Auditoria>[].obs;
  Rx<Auditoria?> auditoria = Auditoria().obs;
  RxList<PuntoFijo> puntosFijos = <PuntoFijo>[].obs;
  RxList<Detalle> detalles = <Detalle>[].obs;

  final responsableController = TextEditingController();
  final nombreController = TextEditingController();
  final sectorController = TextEditingController();
  final organizacionController = TextEditingController();
  final areaController = TextEditingController();
  final codigoController = TextEditingController();

  RxList<Reporte> reporteAvisos = <Reporte>[].obs;
  RxList<Reporte> reporteInspecciones = <Reporte>[].obs;

  RxBool cargandoAuditorias = false.obs;
  RxBool cargandoInspecciones = false.obs;
  RxBool cargandoReporte = true.obs;

  Rx<AuditoriaState> auditoriaState = AuditoriaState.initial.obs;

  //Detalle
  Rx<Detalle?> detalle = Detalle().obs;
  RxList<CategoriaElement> categorias = <CategoriaElement>[].obs;
  RxList<ComponenteElement> componentes = <ComponenteElement>[].obs;
  final referenciaController = TextEditingController();
  final aspectoObservacionController = TextEditingController();
  final detalleController = TextEditingController();

  Rx<CategoriaElement?> categoriaIndex = CategoriaElement().obs;
  Rx<ComponenteElement?> componenteIndex = ComponenteElement().obs;
  Rx<String> configuracion = ''.obs;

  RxList<String> configuracionNames = <String>[].obs;
  RxList<ConfiguracionCombo> configuracionValues = <ConfiguracionCombo>[].obs;
  Rx<ConfiguracionCombo> configuracionIndex = ConfiguracionCombo(id: -20).obs;

  @override
  void onInit() {
    validateOptions();
    super.onInit();
  }

  Future<void> validateOptions() async {
    darkTheme(await localRepository.isDarkMode());
    onlineMode(await localRepository.isOnlineMode());
  }

  void changeMostrar({required bool isChange}) {
    mostrar(isChange);
  }

  void changeItemSeleccionado(int value) {
    itemSeleccionado(value);
  }

  Future<void> syncAuditoria(int auditoriaId) async {
    auditoriaState(AuditoriaState.loading);

    final usuario = await localRepository.getExistUsuario();
    final auditoriaResponse =
        await apiRepository.getAuditoriasByOne(usuario!.token, auditoriaId);

    if (auditoriaResponse.statusCode == 200) {
      final data = const Utf8Codec().decode(auditoriaResponse.bodyBytes);
      final modelResponse = auditoriaFromJson(data);
      await localRepository.insertAuditoria(modelResponse);
      auditoriaState(AuditoriaState.initial);
      return;
    }

    if (auditoriaResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(auditoriaResponse.body);
      Get.back();
      Get.snackbar(
        '${unauthorized.status}',
        'No autorizado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      auditoriaState(AuditoriaState.initial);
      await localRepository.deleteAll();
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final error = badResponseFromJson(auditoriaResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }

    Get.back();
    Get.snackbar(
      'Mensaje',
      descripcion.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
    auditoriaState(AuditoriaState.initial);
  }

  Future<void> getAuditoriaById(int auditoriaId) async {
    final a = await localRepository.getAuditoriaById(auditoriaId);
    if (a != null) {
      auditoria.value = a;
      responsableController.text = a.responsable?.nombreCompleto ?? '';
      nombreController.text = a.nombre;
      sectorController.text = a.sector?.nombre ?? '';
      organizacionController.text = a.organizacion?.nombre ?? '';
      areaController.text = a.area?.nombre ?? '';
      codigoController.text = a.codigo;
    }
  }

  void updateEstado(TipoDocumento? e) {
    auditoria.update((val) {
      val?.estado = e!.id;
    });
    updateAuditoria(auditoria.value);
  }

  void updateNombre() {
    auditoria.update((val) {
      val!.nombre = nombreController.text;
    });
    updateAuditoria(auditoria.value);
  }

  Future<void> updateAuditoria(Auditoria? auditoria) async {
    await localRepository.updateAuditoria(auditoria);
  }

  Future<void> getPuntosFijosById(int id) async {
    puntosFijos.value = await localRepository.getPuntosFijosById(id);
  }

  Future<void> getDetallesById(int id) async {
    detalles.value = await localRepository.getDetallesById(id);
  }

  Future<void> deleteDetalle(int id) async {
    detalles.removeWhere((element) => element.id == id);
  }

  Future<void> saveFilesPuntoFijo(
      List<PlatformFile> paths, PuntoFijo p, int index) async {
    final usuario = await localRepository.getExistUsuario();
    for (final e in paths) {
      final type = e.name.substring(e.name.lastIndexOf('.'));
      final fileNewName = getFechaFile(usuario!.auditorId, type);
      final fileName = basename(e.path!);
      final path = await createFileGallery(e, fileName, fileNewName);

      p.url = fileNewName;
      p.path = path;

      await localRepository.updatePuntoFijo(p);
      puntosFijos[index].url = fileNewName;
      puntosFijos[index].path = path;
      puntosFijos.refresh();
      update();
    }
  }

  Future<void> saveCameraPuntoFijo(XFile e, PuntoFijo p, int index) async {
    final usuario = await localRepository.getExistUsuario();
    final type = e.name.substring(e.name.lastIndexOf('.'));
    final fileNewName = getFechaFile(usuario!.auditorId, type);
    final fileName = basename(e.path);
    final path = await createFileCamera(e, fileName, fileNewName);

    p.url = fileNewName;
    p.path = path;

    await localRepository.updatePuntoFijo(p);
    puntosFijos[index].url = fileNewName;
    puntosFijos[index].path = path;
    puntosFijos.refresh();
    update();
  }

  Future<void> clearDetalle() async {
    detalle.value = Detalle();
    configuracionNames.clear();
    configuracionValues.clear();
    categorias.clear();
    componentes.clear();
    referenciaController.clear();
    aspectoObservacionController.clear();
    detalleController.clear();
  }

  Future<void> getDetalleById(int detalleId, int auditoriaId) async {
    await clearDetalle();

    final a = await localRepository.getAuditoriaById(auditoriaId);

    if (a?.s1 == true) {
      configuracionNames.add("S1");
    }
    if (a?.s2 == true) {
      configuracionNames.add("S2");
    }
    if (a?.s3 == true) {
      configuracionNames.add("S3");
    }
    if (a?.s4 == true) {
      configuracionNames.add("S4");
    }
    if (a?.s5 == true) {
      configuracionNames.add("S5");
    }

    configuracion(configuracionNames[0]);

    configuracionValues
        .add(ConfiguracionCombo(id: a?.configuracion?.valorS1 ?? 0));
    configuracionValues
        .add(ConfiguracionCombo(id: a?.configuracion?.valorS2 ?? 0));
    configuracionValues
        .add(ConfiguracionCombo(id: a?.configuracion?.valorS3 ?? 0));
    configuracionValues
        .add(ConfiguracionCombo(id: a?.configuracion?.valorS4 ?? 0));
    configuracionValues
        .add(ConfiguracionCombo(id: a?.configuracion?.valorS5 ?? 0));

    final d = await localRepository.getDetalleById(detalleId);

    if (d != null) {
      detalle.value = d;

      final list = a?.categorias;
      if (list != null) {
        if (list.isNotEmpty) {
          categorias(list);
          final categoria = list
              .where(
                  (element) => element.categoriaId == d.categoria?.categoriaId)
              .first;
          componentes(categoria.componentes);
        }
      }

      categoriaIndex(CategoriaElement(
        categoriaId: d.categoria?.categoriaId,
        nombre: d.categoria?.nombre,
      ));

      componenteIndex(ComponenteElement(
        categoriaId: d.componente?.componenteId,
        nombre: d.componente?.nombre,
      ));

      referenciaController.text = d.nombre ?? '';
      aspectoObservacionController.text = d.aspectoObservado ?? '';

      if (d.s1 != 0) {
        configuracion('S1');
        configuracionIndex(ConfiguracionCombo(id: d.s1));
      }
      if (d.s2 != 0) {
        configuracion('S2');
        configuracionIndex(ConfiguracionCombo(id: d.s2));
      }
      if (d.s3 != 0) {
        configuracion('S3');
        configuracionIndex(ConfiguracionCombo(id: d.s3));
      }
      if (d.s4 != 0) {
        configuracion('S4');
        configuracionIndex(ConfiguracionCombo(id: d.s4));
      }
      if (d.s5 != 0) {
        configuracion('S5');
        configuracionIndex(ConfiguracionCombo(id: d.s5));
      }
      detalleController.text = d.detalle ?? '';
    } else {
      detalle.value = Detalle(auditoriaId: auditoriaId);

      categorias(a?.categorias);
      final categoria = a?.categorias?[0];
      if (categoria != null) {
        componentes(categoria.componentes);
      }

      categoriaIndex(CategoriaElement());
      componenteIndex(ComponenteElement());

      referenciaController.clear();
      aspectoObservacionController.clear();
      detalleController.clear();
    }
  }

  void updateCategoria(CategoriaElement? c) {
    categoriaIndex(c);
    componentes(c?.componentes);
    componenteIndex(c?.componentes[0]);

    detalle.update((val) {
      final categoria = DetalleCategoria(
        categoriaId: c?.categoriaId,
        nombre: c?.nombre,
      );
      val?.categoria = categoria;
      val?.categoriaId = categoria.categoriaId ?? 0;

      final component = DetalleComponente(
        componenteId: c?.componentes[0].componenteId,
        nombre: c?.componentes[0].nombre,
      );

      val?.componente = component;
      val?.componenteId = component.componenteId ?? 0;
    });
  }

  void updateComponente(ComponenteElement? value) {
    componenteIndex(value);

    detalle.update((val) {
      val?.componenteId = value?.componenteId ?? 0;
      val?.componente = DetalleComponente(
        componenteId: value?.componenteId,
        nombre: value?.nombre,
      );
    });
  }

  void updateReferencia() {
    detalle.update((val) {
      val?.nombre = referenciaController.text;
    });
  }

  void updateAspectoObservado() {
    detalle.update((val) {
      val?.aspectoObservado = aspectoObservacionController.text;
    });
  }

  void updateDetalle() {
    detalle.update((val) {
      val?.detalle = detalleController.text;
    });
  }

  void updateConfiguracion(String? value) {
    configuracion(value);

    final valorS = configuracionIndex.value;

    detalle.update((val) {
      val?.s1 = 0;
      val?.s2 = 0;
      val?.s3 = 0;
      val?.s4 = 0;
      val?.s5 = 0;

      switch (configuracion.value) {
        case 'S1':
          val?.s1 = valorS.id;
          break;
        case 'S2':
          val?.s2 = valorS.id;
          break;
        case 'S3':
          val?.s3 = valorS.id;
          break;
        case 'S4':
          val?.s4 = valorS.id;
          break;
        case 'S5':
          val?.s5 = valorS.id;
          break;
      }
    });
  }

  void updateConfiguracionCombo(ConfiguracionCombo? value) {
    configuracionIndex(value);
    detalle.update((val) {
      val?.s1 = 0;
      val?.s2 = 0;
      val?.s3 = 0;
      val?.s4 = 0;
      val?.s5 = 0;

      switch (configuracion.value) {
        case 'S1':
          val?.s1 = value?.id ?? 0;
          break;
        case 'S2':
          val?.s2 = value?.id ?? 0;
          break;
        case 'S3':
          val?.s3 = value?.id ?? 0;
          break;
        case 'S4':
          val?.s4 = value?.id ?? 0;
          break;
        case 'S5':
          val?.s5 = value?.id ?? 0;
          break;
      }
    });
  }

  void updateFinalizado(bool? value) {
    detalle.update((val) {
      val?.finalizado = value ?? false;
    });
  }

  Future<void> saveFilesDetalle(List<PlatformFile> paths) async {
    final usuario = await localRepository.getExistUsuario();
    for (final e in paths) {
      final type = e.name.substring(e.name.lastIndexOf('.'));
      final fileNewName = getFechaFile(usuario!.auditorId, type);
      final fileName = basename(e.path!);
      final path = await createFileGallery(e, fileName, fileNewName);

      detalle.update((val) {
        val?.url = fileNewName;
        val?.path = path;
      });
    }
  }

  Future<void> saveCameraDetalle(XFile e) async {
    final usuario = await localRepository.getExistUsuario();
    final type = e.name.substring(e.name.lastIndexOf('.'));
    final fileNewName = getFechaFile(usuario!.auditorId, type);
    final fileName = basename(e.path);
    final path = await createFileCamera(e, fileName, fileNewName);

    detalle.update((val) {
      val?.url = fileNewName;
      val?.path = path;
    });
  }

  Future<String> validateDetalle(int index) async {
    if (categoriaIndex.value?.categoriaId == 0) {
      return 'Eliga una categoria';
    }
    if (componenteIndex.value?.componenteId == 0) {
      return 'Eliga un componente';
    }
    if (referenciaController.text.isEmpty) {
      return 'Escriba una referencia';
    }
    if (aspectoObservacionController.text.isEmpty) {
      return 'Escriba un aspecto observado';
    }

    final d = detalle.value;
    if (d != null) {
      await localRepository.insertDetalle(d);

      if (index != -1) {
        detalles[index] = d;
      } else {
        detalles.add(d);
      }
    }

    return '';
  }

  Future<void> sendAuditoria(int auditoriaId) async {
    auditoriaState(AuditoriaState.loading);

    final auditoria = await localRepository.getAuditoriaSendById(auditoriaId);
    if (auditoria == null) {
      auditoriaState(AuditoriaState.initial);
      return;
    }
    final paths = <String>[];

    final detalle = auditoria.detalles;
    if (detalle != null) {
      for (final d in detalle) {
        if (d.path.isNotEmpty) {
          paths.add(d.path);
        }
      }
    }

    final puntoFijo = auditoria.puntosFijos;
    if (puntoFijo != null) {
      for (final d in puntoFijo) {
        if (d.path.isNotEmpty) {
          paths.add(d.path);
        }
      }
    }
    final usuario = await localRepository.getExistUsuario();
    final registroReponse = await apiRepository.sendRegister(
        usuario!.token, auditoria.toDataJson(), paths);
    if (registroReponse.statusCode == 200) {
      auditoriaState(AuditoriaState.initial);
      Get.snackbar(
        'Mensaje',
        'Auditoria actualizado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      Get.offAllNamed(AppRoutes.home);
      return;
    }

    if (registroReponse.statusCode == 401) {
      auditoriaState(AuditoriaState.initial);
      final unauthorized = unauthorizedFromJson(registroReponse.body);
      Get.snackbar(
        '${unauthorized.status}',
        'No autorizado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      await localRepository.deleteAll();
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final error = badResponseFromJson(registroReponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }
    auditoriaState(AuditoriaState.initial);
    Get.snackbar(
      'Mensaje',
      descripcion.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  Future<void> closeAuditoria(int id) async {
    await localRepository.deleteOffLineAuditoriaById(id);
  }
}
