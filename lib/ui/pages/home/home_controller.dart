import 'dart:convert';

import 'package:app_fivesys/helpers/app_navigation.dart';
import 'package:app_fivesys/helpers/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/data/repository/local_repository.dart';
import 'package:app_fivesys/data/repository/api_repository.dart';

import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/domain/models/offline.dart';
import 'package:app_fivesys/domain/models/reporte.dart';
import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/domain/response/response.dart';

import 'package:app_fivesys/helpers/util.dart';

enum HomeState {
  loading,
  initial,
}

class HomeController extends GetxController {
  HomeController({
    required this.localRepository,
    required this.apiRepository,
  });
  final LocalRepository localRepository;
  final ApiRepository apiRepository;

  Rx<Usuario> usuario = Usuario().obs;
  RxInt itemSeleccionado = 0.obs;
  RxBool mostrar = true.obs;
  RxBool darkTheme = false.obs;
  RxBool onlineMode = true.obs;

  RxList<Auditoria> auditorias = <Auditoria>[].obs;
  RxList<Reporte> reporteAvisos = <Reporte>[].obs;
  RxList<Reporte> reporteInspecciones = <Reporte>[].obs;

  int _countAuditoriasPage = 0;
  bool _isFilter = false;
  get isFilter => _isFilter;

  RxBool cargandoAuditorias = false.obs;
  RxBool cargandoReporte = true.obs;

  Rx<HomeState> state = HomeState.initial.obs;
  Rx<HomeState> stateAuditoria = HomeState.initial.obs;

  //Busqueda y Nueva Auditoria
  RxList<OrganizacionFiltro> organizaciones = <OrganizacionFiltro>[].obs;
  RxList<AreaFiltro> areas = <AreaFiltro>[].obs;
  RxList<SectorFiltro> sectores = <SectorFiltro>[].obs;
  RxList<ResponsableFiltro> responsables = <ResponsableFiltro>[].obs;

  Rx<Filtro> filtro = Filtro().obs;

  final codigoController = TextEditingController();
  final organizacionController = TextEditingController();
  final areaController = TextEditingController();
  final sectorController = TextEditingController();
  final responsableController = TextEditingController();
  final nombreController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    loadUsuario();
    super.onInit();
  }

  void changeMostrar({required bool isChange}) {
    mostrar(isChange);
  }

  void changeItemSeleccionado(int value) {
    itemSeleccionado(value);
  }

  Future<void> loadUsuario() async {
    final user = await localRepository.getExistUsuario();
    if (user != null) {
      usuario.value = user;
    }
    darkTheme(await localRepository.isDarkMode());
    onlineMode(await localRepository.isOnlineMode());
  }

  Future<bool?> getIsOnline() async {
    final result = await localRepository.isOnlineMode();
    return result ?? true;
  }

  Future<void> onThemeUpdated({required bool theme}) async {
    await localRepository.saveDarkMode(theme);
    darkTheme(theme);
    Get.changeThemeMode(theme ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> logOut() async {
    await localRepository.deleteAll();
  }

  Future<void> initGetAuditorias() async {
    _countAuditoriasPage = 0;
    await clearAuditoria();
    stateAuditoria(HomeState.loading);
    getAuditorias();
  }

  Future<void> clearAuditoria() async {
    auditorias.clear();
  }

  Future<void> getAuditorias() async {
    if (cargandoAuditorias.value) return;
    cargandoAuditorias.value = true;
    _countAuditoriasPage++;

    final usuario = await localRepository.getExistUsuario();
    final auditoriaResponse =
        await apiRepository.pagination(usuario?.token ?? '', {
      'pageIndex': _countAuditoriasPage,
      'pageSize': 20,
      'estado': 0,
    });

    if (auditoriaResponse.statusCode == 200) {
      final modelReponse = auditoriasFromJson(
          const Utf8Codec().decode(auditoriaResponse.bodyBytes));
      if (modelReponse.isEmpty) {
        _countAuditoriasPage--;
      }

      for (var element in modelReponse) {
        final auditoria =
            await localRepository.getAuditoriaOffLineById(element.auditoriaId);
        element.online = auditoria?.estado ?? 0;
        auditorias.add(element);
      }

      stateAuditoria(HomeState.initial);
      cargandoAuditorias.value = false;
      return;
    }

    _countAuditoriasPage = 0;

    if (auditoriaResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(auditoriaResponse.body);
      state(HomeState.initial);

      Get.snackbar(
        '${unauthorized.status}',
        'No autorizado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );

      stateAuditoria(HomeState.initial);
      cargandoAuditorias.value = false;

      await localRepository.deleteAll();
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final error = badResponseFromJson(auditoriaResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }

    Get.snackbar(
      'Mensaje',
      descripcion.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );

    stateAuditoria(HomeState.initial);
    cargandoAuditorias.value = false;
  }

  Future<void> getReporte() async {
    /*  final usuario = await localRepository.getExistUsuario();
    final reporteResponse = await apiRepository
        .getReporteGeneral(usuario!.token, {'userId': usuario.auditorId});

    if (reporteResponse.statusCode == 200) {
      final modelReponse = modelResponseFromJson(reporteResponse.body);
      if (modelReponse.response.codigo == '0000') {
        final reporte = reporteFromJson(json.encode(modelReponse.data));
        reporteAvisos.addAll(reporte.avisos);
        reporteInspecciones.addAll(reporte.ordenesTrabajo);
      } else {
        //  return {'ok': false, 'mensaje': modelReponse.response.comentario};
      }
    } else if (reporteResponse.statusCode == 401) {
      await localRepository.deleteAll();
      Get.offAllNamed(AppRoutes.splash);
    }
    cargandoReporte.value = true; */
  }

  Future<bool> getFiltro(bool isFilter) async {
    _isFilter = isFilter;
    await clearFiltro();
    final user = await localRepository.getExistUsuario();
    final filtroResponse =
        await apiRepository.getFiltroGetAll(user?.token ?? '');
    if (filtroResponse.statusCode == 200) {
      final filtro = offlineFromJson(filtroResponse.body);
      organizaciones.addAll(filtro.organizaciones);
      return true;
    }

    if (filtroResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(filtroResponse.body);

      Get.snackbar(
        '${unauthorized.status}',
        'No autorizado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      await localRepository.deleteAll();
      Get.offAllNamed(AppRoutes.login);
      return false;
    }

    final error = badResponseFromJson(filtroResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }

    Get.snackbar(
      'Mensaje',
      descripcion.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
    return false;
  }

  Future<Map<String, dynamic>> generateAuditoria() async {
    state(HomeState.loading);
    final data = filtro.value;
    final user = await localRepository.getExistUsuario();
    data.auditorId = user?.auditorId ?? 0;
    data.estado = 1;

    final validation = validateFiltro(data);
    if (validation != null) {
      state(HomeState.initial);
      return validation;
    }

    final auditoriaSaveResponse =
        await apiRepository.saveHeader(user?.token ?? '', data.toJson());
    if (auditoriaSaveResponse.statusCode == 200) {
      final auditoriaReponse =
          auditoriaHeaderResponseFromJson(auditoriaSaveResponse.body);
      final argumentos = {
        'auditoriaId': auditoriaReponse.auditoriaId,
        'estado': 1,
        'isOnline': true,
        'result': true,
        'token': user?.token ?? ''
      };
      state(HomeState.initial);
      return argumentos;
    }

    if (auditoriaSaveResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(auditoriaSaveResponse.body);
      state(HomeState.initial);
      return {
        'result': false,
        'status': unauthorized.status,
        'message': '${unauthorized.status}\nNo autorizado'
      };
    }

    final error = badResponseFromJson(auditoriaSaveResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }
    state(HomeState.initial);
    return {'result': false, 'message': descripcion.toString()};
  }

  Map<String, dynamic>? validateFiltro(Filtro f) {
    if (f.organizacionId == 0) {
      final argumentos = {
        'message': 'Seleccione una Organización.',
        'result': false,
      };
      return argumentos;
    }
    if (f.areaId == 0) {
      final argumentos = {
        'message': 'Seleccione un Area.',
        'result': false,
      };
      return argumentos;
    }
    if (f.sectorId == 0) {
      final argumentos = {
        'message': 'Seleccione un Sector.',
        'result': false,
      };
      return argumentos;
    }
    if (f.responsableId == 0) {
      final argumentos = {
        'message': 'Seleccione un Responsable.',
        'result': false,
      };
      return argumentos;
    }
    if (f.nombre.isEmpty) {
      final argumentos = {
        'message': 'Ingrese Nombre.',
        'result': false,
      };
      return argumentos;
    }
    return null;
  }

  Future<void> initGetFilterAuditorias() async {
    _isFilter = true;
    _countAuditoriasPage = 0;
    auditorias.clear();
    stateAuditoria(HomeState.loading);
    getFilterAuditorias();
  }

  Future<void> getFilterAuditorias() async {
    if (cargandoAuditorias.value) return;
    cargandoAuditorias.value = true;
    _countAuditoriasPage++;

    final data = filtro.value;
    final user = await localRepository.getExistUsuario();
    data.auditorId = user?.auditorId ?? 0;
    data.pageIndex = _countAuditoriasPage;
    data.pageSize = 20;

    final auditoriaResponse =
        await apiRepository.pagination(user?.token ?? '', data.toJson());

    if (auditoriaResponse.statusCode == 200) {
      final modelReponse = auditoriasFromJson(
          const Utf8Codec().decode(auditoriaResponse.bodyBytes));
      if (modelReponse.isEmpty) {
        _countAuditoriasPage--;
      }
      auditorias.addAll(modelReponse);
      stateAuditoria(HomeState.initial);
      cargandoAuditorias.value = false;
      return;
    }

    _countAuditoriasPage = 0;

    if (auditoriaResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(auditoriaResponse.body);
      state(HomeState.initial);

      Get.snackbar(
        '${unauthorized.status}',
        'No autorizado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );

      stateAuditoria(HomeState.initial);
      cargandoAuditorias.value = false;

      await localRepository.deleteAll();
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final error = badResponseFromJson(auditoriaResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }

    Get.snackbar(
      'Mensaje',
      descripcion.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );

    stateAuditoria(HomeState.initial);
    cargandoAuditorias.value = false;
  }

  //Filtro
  Future<void> clearFiltro() async {
    organizaciones.clear();
    areas.clear();
    sectores.clear();
    responsables.clear();
    codigoController.clear();
    nombreController.clear();
    filtro.value = Filtro();
  }

  void updateCodigo() {
    filtro.update((val) {
      val?.codigo = codigoController.text;
    });
  }

  void updateEstado(TipoDocumento? value) {
    filtro.update((val) {
      val?.estado = value?.id ?? 0;
    });
  }

  void changeOrganizacion(OrganizacionFiltro o) async {
    areas.clear();
    sectores.clear();
    responsables.clear();

    filtro.update((val) {
      val?.organizacionId = o.organizacionId;
      val?.organizacionNombre = o.nombre;

      final organizacion = organizaciones
          .where((e) => e.organizacionId == o.organizacionId)
          .first;

      final a = organizacion.areas;

      if (a == null || a.isEmpty) {
        val?.areaId = 0;
        val?.areaNombre = '';
        return;
      }

      if (a.isNotEmpty) {
        areas.addAll(a);
        final _area = a[0];
        val?.areaId = _area.areaId;
        val?.areaNombre = _area.nombre;

        final s = _area.sectores;
        if (s == null || s.isEmpty) {
          val?.sectorId = 0;
          val?.sectorNombre = '';
          return;
        }
        if (s.isNotEmpty) {
          sectores.addAll(s);
          final _sector = s[0];
          val?.sectorId = _sector.sectorId;
          val?.sectorNombre = _sector.nombre;

          final r = _sector.responsables;
          if (r == null || r.isEmpty) {
            val?.responsableId = 0;
            val?.responsable = '';
            return;
          }

          if (r.isNotEmpty) {
            responsables.addAll(r);
            final _responsable = r[0];
            val?.responsableId = _responsable.responsableId;
            val?.responsable = _responsable.nombreCompleto;
          }
        }
      }
    });
  }

  void changeArea(AreaFiltro a) async {
    sectores.clear();
    responsables.clear();
    filtro.update((val) {
      val?.areaId = a.areaId;
      val?.areaNombre = a.nombre;

      final data = areas.where((e) => e.areaId == a.areaId).first;
      final s = data.sectores;
      if (s == null || s.isEmpty) {
        val?.sectorId = 0;
        val?.sectorNombre = '';
        return;
      }
      if (s.isNotEmpty) {
        sectores.addAll(s);
        final _sector = s[0];
        val?.sectorId = _sector.sectorId;
        val?.sectorNombre = _sector.nombre;

        final r = _sector.responsables;
        if (r == null || r.isEmpty) {
          val?.responsableId = 0;
          val?.responsable = '';
          return;
        }

        if (r.isNotEmpty) {
          responsables.addAll(r);
          final _responsable = r[0];
          val?.responsableId = _responsable.responsableId;
          val?.responsable = _responsable.nombreCompleto;
        }
      }
    });
  }

  void changeSector(SectorFiltro a) async {
    responsables.clear();
    filtro.update((val) {
      val?.sectorId = a.sectorId;
      val?.sectorNombre = a.nombre;
      final data = sectores.where((e) => e.sectorId == a.sectorId).first;
      final r = data.responsables;
      if (r == null || r.isEmpty) {
        val?.responsableId = 0;
        val?.responsable = '';
        return;
      }
      if (r.isNotEmpty) {
        responsables.addAll(r);
        final _responsable = r[0];
        val?.responsableId = _responsable.responsableId;
        val?.responsable = _responsable.nombreCompleto;
      }
    });
  }

  void changeResponsable(ResponsableFiltro a) {
    filtro.update((val) {
      val?.responsableId = a.responsableId;
      val?.responsable = a.nombreCompleto;
    });
  }

  void updateArea() {
    filtro.update((val) {
      val?.area = areaController.text;
    });
  }

  void updateSector() {
    filtro.update((val) {
      val?.sector = sectorController.text;
    });
  }

  void updateResponsable() {
    filtro.update((val) {
      val?.responsable = responsableController.text;
    });
  }

  void updateNombre() {
    filtro.update((val) {
      val?.nombre = nombreController.text;
    });
  }

  void updateS1toS5(value, position) {
    filtro.update((val) {
      switch (position) {
        case 1:
          val?.s1 = value;
          break;
        case 2:
          val?.s2 = value;
          break;
        case 3:
          val?.s3 = value;
          break;
        case 4:
          val?.s4 = value;
          break;
        case 5:
          val?.s5 = value;
      }
    });
  }

  // Modo Offline

  Future<void> changeOffline() async {
    final result = await permissionWrite();
    if (!result) {
      return;
    }

    state(HomeState.loading);
    final user = await localRepository.getExistUsuario();
    final token = user!.token;

    await localRepository.deleteOffLineAuditoria();

    final offAuditoria = await localRepository.getAuditoriasOffLine();
    for (var element in offAuditoria) {
      final auditoriaResponse =
          await apiRepository.getAuditoriasByOne(token, element.auditoriaId);

      if (auditoriaResponse.statusCode == 200) {
        final data = const Utf8Codec().decode(auditoriaResponse.bodyBytes);
        final modelResponse = auditoriaFromJson(data);
        modelResponse.online = 1;

        final listDetail = <Detalle>[];
        final listPuntosFijos = <PuntoFijo>[];

        final detalles = modelResponse.detalles;
        if (detalles != null) {
          for (var d in detalles) {
            final path = await downloadImage(token, d.fotoId ?? 0);
            d.path = path;
            final pathPadre =
                await downloadImage(token, d.auditoriaDetallePadreFotoId ?? 0);
            d.pathPadre = pathPadre;
            listDetail.add(d);
          }
        }

        final puntoFijos = modelResponse.puntosFijos;
        if (puntoFijos != null) {
          for (var d in puntoFijos) {
            final path = await downloadImage(token, d.fotoId ?? 0);
            d.path = path;
            listPuntosFijos.add(d);
          }
        }

        modelResponse.detalles = listDetail;
        modelResponse.puntosFijos = listPuntosFijos;

        await localRepository.insertAuditoria(modelResponse);
      }
    }

    await localRepository.clearTemporaryCheckOffline();

    final filtroResponse = await apiRepository.getFiltroGetAll(token);
    if (filtroResponse.statusCode == 200) {
      final filtro = offlineFromJson(filtroResponse.body);
      await localRepository.insertDataOffline(filtro);
      await localRepository.saveOnlineMode(false);

      onlineMode(false);
      Get.snackbar(
        'Mensaje',
        'Modo Offline',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      state(HomeState.initial);
      return;
    }

    if (filtroResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(filtroResponse.body);
      Get.snackbar(
        '${unauthorized.status}',
        'No autorizado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      state(HomeState.initial);

      await localRepository.deleteAll();
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final error = badResponseFromJson(filtroResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }
    Get.snackbar(
      'Mensaje',
      descripcion.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
    state(HomeState.initial);
  }

  Future<void> changeOnline() async {
    state(HomeState.loading);
    var resultOk = '';

    final data = await localRepository.getOffLineSendAuditorias();
    if (data.isNotEmpty) {
      for (final auditoria in data) {
        final paths = <String>[];
        final listDetail = <Detalle>[];
        final listPuntosFijos = <PuntoFijo>[];

        final detalle = auditoria.detalles;
        if (detalle != null) {
          for (final d in detalle) {
            if (d.path.isNotEmpty) {
              paths.add(d.path);
            }
            if (auditoria.online == 0) {
              d.auditoriaId = 0;
            }
            listDetail.add(d);
          }
        }

        final puntoFijo = auditoria.puntosFijos;
        if (puntoFijo != null) {
          for (final d in puntoFijo) {
            if (d.path.isNotEmpty) {
              paths.add(d.path);
            }
            if (auditoria.online == 0) {
              d.auditoriaId = 0;
            }

            listPuntosFijos.add(d);
          }
        }
        if (auditoria.online == 0) {
          auditoria.auditoriaId = 0;
        }
        auditoria.detalles = listDetail;
        auditoria.puntosFijos = listPuntosFijos;

        final usuario = await localRepository.getExistUsuario();
        final registroReponse = await apiRepository.sendRegisterOffLine(
            usuario?.token ?? '', auditoria.toDataJsonOffline(), paths);
        if (registroReponse.statusCode == 200) {
          //final success = successResponseFromJson(registroReponse.body);
          //resultOk = success.mensaje;
          resultOk = 'Datos enviados';
        } else if (registroReponse.statusCode == 401) {
          state(HomeState.initial);
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
        } else {
          state(HomeState.initial);
          final error = badResponseFromJson(registroReponse.body);
          final descripcion = StringBuffer();
          for (final it in error.errores) {
            descripcion.write('$it\n');
          }
          Get.snackbar(
            'Mensaje',
            descripcion.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
          );
          return;
        }
      }
    }

    if (resultOk.isNotEmpty) {
      await deleteDirectoy();
      await localRepository.deleteOffLineAuditoria();
      await localRepository.saveOnlineMode(true);
      onlineMode(true);
      state(HomeState.initial);
      Get.snackbar(
        'Mensaje',
        resultOk,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } else {
      Future.delayed(const Duration(milliseconds: 1500), () async {
        await localRepository.saveOnlineMode(true);
        onlineMode(true);
        state(HomeState.initial);
      });
    }
  }

  Future<void> getOfflineAuditorias() async {
    auditorias.clear();
    final a = await localRepository.getOfflineAuditorias();
    auditorias(a);
  }

  Future<void> getFilterOfflineAuditorias() async {
    _isFilter = true;
    auditorias.clear();

    final data = filtro.value;
    final newAuditorias = await localRepository.getOfflineAuditorias();

    final a = newAuditorias.where((a) {
      var ok = false;
      if (data.codigo.isNotEmpty) {
        ok = a.codigo.toLowerCase().contains(data.codigo);
      }

      if (data.estado > 0) {
        ok = a.estado == data.estado;
      }

      if (data.areaId > 0) {
        if (a.area?.areaId == data.areaId) {
          ok = a.area?.areaId == data.areaId;
        }
      }

      if (data.sectorId > 0) {
        if (a.sector?.sectorId == data.sectorId) {
          ok = a.sector?.sectorId == data.sectorId;
        }
      }

      if (data.responsableId > 0) {
        if (a.responsable?.responsableId == data.responsableId) {
          ok = a.responsable?.responsableId == data.responsableId;
        }
      }

      if (data.nombre.isNotEmpty) {
        ok = a.nombre.toLowerCase().contains(data.nombre);
      }

      return ok;
    }).toList();
    auditorias(a);
  }

  Future<void> getFiltroOffline(bool isFilter) async {
    await clearFiltro();
    _isFilter = isFilter;
    final a = await localRepository.getFiltroOffLine();
    organizaciones(a);
  }

  Future<Map<String, dynamic>> generateAuditoriaOffline() async {
    final data = filtro.value;
    final user = await localRepository.getExistUsuario();
    data.auditorId = user?.auditorId ?? 0;
    data.estado = 1;

    final validation = validateFiltro(data);
    if (validation != null) {
      return validation;
    }
    final auditoriaId = await localRepository.generateAuditoriaOffline(data);
    final argumentos = {
      'auditoriaId': auditoriaId,
      'estado': 1,
      'isOnline': false,
      'result': true,
      'token': user?.token ?? ''
    };

    return argumentos;
  }

  void deleteAuditoria(int id, int index) async {
    await localRepository.deleteOffLineAuditoriaById(id);

    auditorias.removeAt(index);
    update();

    Get.snackbar(
      'Mensaje',
      'Auditoria eliminada.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  void clearEmail() {
    emailController.clear();
  }

  Future<Map<String, dynamic>> validateEmail(int id) async {
    final email = emailController.text;
    if (email.isEmpty) {
      return {'result': false, 'message': 'Ingrese Email.'};
    }
    if (!isEmail(email)) {
      return {'result': false, 'message': 'Email no es correcto.'};
    }
    return sendEmailAuditoria(id, email);
  }

  Future<Map<String, dynamic>> sendEmailAuditoria(int id, String email) async {
    state(HomeState.loading);
    final usuario = await localRepository.getExistUsuario();
    final emailResponse =
        await apiRepository.sendEmail(usuario?.token ?? '', id, email);

    if (emailResponse.statusCode == 200) {
      final success = successResponseFromJson(emailResponse.body);
      state(HomeState.initial);
      return {'result': true, 'message': success.mensaje};
    }

    if (emailResponse.statusCode == 401) {
      final unauthorized = unauthorizedFromJson(emailResponse.body);
      state(HomeState.initial);
      return {
        'result': false,
        'status': unauthorized.status,
        'message': '${unauthorized.status}\nNo autorizado'
      };
    }

    final error = badResponseFromJson(emailResponse.body);
    final descripcion = StringBuffer();
    for (final it in error.errores) {
      descripcion.write('$it\n');
    }

    state(HomeState.initial);
    return {'result': false, 'message': descripcion.toString()};
  }

  Future<String> getToken() async {
    final usuario = await localRepository.getExistUsuario();
    return usuario?.token ?? '';
  }

  void updateAuditoriaOffLine(int index, bool value) async {
    auditorias[index].online = value ? 1 : 0;
    auditorias.refresh();
    update();

    final auditoria = auditorias[index];

    final offline = AuditoriaOffLine(
        auditoriaId: auditoria.auditoriaId, estado: value ? 1 : 0);
    await localRepository.saveAuditoriaOffLine(offline);
  }

  void downloadPdf(int auditoriaId) async {
    final result = await permissionWrite();
    if (!result) {
      return;
    }

    final usuario = await localRepository.getExistUsuario();
    final downloadResponse =
        await apiRepository.getDownloadPdf(usuario?.token ?? '', auditoriaId);

    if (downloadResponse.statusCode == 200) {
      final url = await savePdf(
          downloadResponse.bodyBytes, 'Auditoria-$auditoriaId.pdf');

      NotificationService().showNotification(1, 'Auditoria $auditoriaId',
          'Guardado en tus archivos de descarga', 1, url);
    }
  }

  Future<String> downloadImage(String token, int id) async {
    final downloadResponse = await apiRepository.getDownloadImage(token, id);

    if (downloadResponse.statusCode != 200) {
      return '';
    }
    final path = getFechaFile(id, '.jpg');
    final url = await saveImage(downloadResponse.bodyBytes, path);

    return url;
  }
}
