import 'package:app_fivesys/data/repository/local_repository.dart';
import 'package:app_fivesys/domain/app_data_base.dart';
import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/domain/models/offline.dart';
import 'package:app_fivesys/domain/models/setting.dart';
import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:app_fivesys/helpers/util.dart';

const name = 'app-fivesys';
const pass = 'h8iqgdgp';

class LocalRepositoryImpl extends LocalRepository {
  @override
  Future<List<Usuario>> getUsuarios() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.usuarioDao.getUsuario();
  }

  @override
  Future<Usuario?> getExistUsuario() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.usuarioDao.getExistUsuario();
  }

  @override
  Future<void> insertUsuario(Usuario u) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    database.usuarioDao.insertUsuarioTask(u);
  }

  @override
  Future<void> updateUsuario(Usuario u) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    database.usuarioDao.updateUsuarioTask(u);
  }

  @override
  Future<void> deleteAll() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    database.usuarioDao.deleteAll();
    database.auditoriaOffLineDao.deleteAll();
    final isDark = await database.settingDao.getIsDarkMode();
    database.settingDao.updateSettingTask(
        Setting(isDarkMode: isDark ?? false, isOnline: true));

    database.auditoriaDao.deleteAll();
    database.detalleDao.deleteAll();
    database.puntoFijoDao.deleteAll();
    database.organizacionFiltroDao.deleteAll();
    database.categoriaFiltroDao.deleteAll();
    database.configuracionFiltroDao.deleteAll();
  }

  @override
  Future<bool?> isDarkMode() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.settingDao.getIsDarkMode();
  }

  @override
  Future<bool?> isOnlineMode() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.settingDao.getIsOnlineMode();
  }

  @override
  Future<void> saveDarkMode(bool darkMode) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    final isOnline = await database.settingDao.getIsOnlineMode();
    final setting = Setting(isDarkMode: darkMode, isOnline: isOnline ?? true);
    database.settingDao.insertSettingTask(setting);
  }

  @override
  Future<void> saveOnlineMode(bool onlineMode) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    final isDarkMode = await database.settingDao.getIsDarkMode();
    final setting =
        Setting(isOnline: onlineMode, isDarkMode: isDarkMode ?? false);
    database.settingDao.insertSettingTask(setting);
  }

  @override
  Future<void> deleteOffLineAuditoria() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    database.detalleDao.deleteAll();
    database.puntoFijoDao.deleteAll();
    database.organizacionFiltroDao.deleteAll();
    database.categoriaFiltroDao.deleteAll();
    database.configuracionFiltroDao.deleteAll();
  }

  @override
  Future<void> insertAuditoria(Auditoria a) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    await database.auditoriaDao.deleteAuditoriaById(a.auditoriaId);
    await database.detalleDao.deleteDetallesById(a.auditoriaId);
    await database.puntoFijoDao.deletePuntoFijoById(a.auditoriaId);

    a.fechaRegistro = '01/01/0001';
    database.auditoriaDao.insertAuditoriaTask(a);

    final detalle = a.detalles;
    if (detalle != null) {
      for (final d in detalle) {
        final identity = await database.detalleDao.getDetalleIdentity();
        d.id = (identity == null || identity == 0) ? 1 : identity + 1;
        database.detalleDao.insertDetalleTask(d);
      }
    }
    final puntoFijo = a.puntosFijos;
    if (puntoFijo != null) {
      database.puntoFijoDao.insertPuntoFijoListTask(puntoFijo);
    }
  }

  @override
  Future<Auditoria?> getAuditoriaById(int auditoriaId) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.auditoriaDao.getAuditoriaById(auditoriaId);
  }

  @override
  Future<Auditoria?> getAuditoriaSendById(int auditoriaId) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    final auditoria = await database.auditoriaDao.getAuditoriaById(auditoriaId);

    auditoria?.detalles =
        await database.detalleDao.getDetallesById(auditoriaId);
    auditoria?.puntosFijos =
        await database.puntoFijoDao.getPuntoFijoById(auditoriaId);
    return auditoria;
  }

  @override
  Future<void> updateAuditoria(Auditoria? auditoria) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    if (auditoria != null) {
      database.auditoriaDao.updateAuditoriaTask(auditoria);
    }
  }

  @override
  Future<List<PuntoFijo>> getPuntosFijosById(int id) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.puntoFijoDao.getPuntoFijoById(id);
  }

  @override
  Future<void> updatePuntoFijo(PuntoFijo p) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    database.puntoFijoDao.updatePuntoFijoTask(p);
  }

  @override
  Future<List<Detalle>> getDetallesById(int id) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.detalleDao.getDetallesById(id);
  }

  @override
  Future<Detalle?> getDetalleById(int id) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.detalleDao.getDetalleById(id);
  }

  @override
  Future<void> insertDetalle(Detalle d) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    final detalle = await database.detalleDao.getDetalleById(d.id);
    if (detalle == null) {
      final result = await database.detalleDao.getDetalleIdentity();
      final identity = (result == null || result == 0) ? 1 : result + 1;
      d.id = identity;
      database.detalleDao.insertDetalleTask(d);
    } else {
      database.detalleDao.updateDetalleTask(d);
    }
  }

  @override
  Future<void> insertDataOffline(Offline f) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    final organizacion = f.organizaciones;
    if (organizacion.isNotEmpty) {
      database.organizacionFiltroDao.insertOrganizacionFiltroTask(organizacion);
    }
    final categorias = f.categorias;
    if (categorias.isNotEmpty) {
      database.categoriaFiltroDao.insertCategoriaFiltroListTask(categorias);
    }
    database.configuracionFiltroDao
        .insertConfiguracionFiltroTask(f.configuracion);
  }

  @override
  Future<List<OrganizacionFiltro>> getFiltroOffLine() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.organizacionFiltroDao.getOrganizacionFiltro();
  }

  @override
  Future<List<Auditoria>> getOfflineAuditorias() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.auditoriaDao.getAuditorias();
  }

  @override
  Future<int> generateAuditoriaOffline(Filtro f) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    final result = await database.auditoriaDao.getAuditoriaIdentity();
    final identity = (result == null || result == 0) ? 1 : result + 1;

    final a = Auditoria();
    a.auditoriaId = identity;
    a.auditorId = f.auditorId;
    a.codigo = getAuditoriaCodigoCorrelativo(identity);
    a.estado = f.estado;
    a.nombre = f.nombre;
    a.s1 = f.s1;
    a.s2 = f.s2;
    a.s3 = f.s3;
    a.s4 = f.s4;
    a.s5 = f.s5;
    a.responsableId = f.responsableId;
    a.fechaRegistro = getFecha();

    final organizaciones =
        await database.organizacionFiltroDao.getOrganizacionFiltro();
    if (organizaciones.isNotEmpty) {
      final organizacion = organizaciones
          .where((e) => e.organizacionId == f.organizacionId)
          .first;

      a.organizacion = Organizacion(
          organizacionId: organizacion.organizacionId,
          nombre: organizacion.nombre);

      final area = organizacion.areas?.where((e) => e.areaId == f.areaId).first;
      if (area != null) {
        a.area = Area(areaId: area.areaId, nombre: area.nombre);

        final sector =
            area.sectores?.where((e) => e.sectorId == f.sectorId).first;
        if (sector != null) {
          a.sector = Sector(sectorId: sector.sectorId, nombre: sector.nombre);

          final responsable = sector.responsables
              ?.where((e) => e.responsableId == f.responsableId)
              .first;

          if (responsable != null) {
            a.responsable = Responsable(
                responsableId: responsable.responsableId,
                nombreCompleto: responsable.nombreCompleto);
          }

          List<PuntoFijo>? lista = [];
          final puntos = sector.puntosFijos;
          if (puntos != null) {
            for (final p in puntos) {
              lista.add(PuntoFijo(
                auditoriaId: identity,
                puntoFijoId: p.puntoFijoId,
                nPuntoFijo: p.nombre,
              ));
            }
            database.puntoFijoDao.insertPuntoFijoListTask(lista);
          }
        }
      }
    }

    final categorias = await database.categoriaFiltroDao.getCategoriaFiltro();
    if (categorias.isNotEmpty) {
      List<CategoriaElement>? lista = [];

      for (final c in categorias) {
        List<ComponenteElement> listaC = [];

        final componentes = c.componentes;
        if (componentes != null) {
          for (final o in componentes) {
            listaC.add(ComponenteElement(
              categoriaId: o.categoriaId,
              componenteId: o.componenteId,
              nombre: o.nombre,
            ));
          }
        }

        lista.add(CategoriaElement(
          categoriaId: c.categoriaId,
          nombre: c.nombre,
          componentes: listaC,
        ));
      }
      a.categorias = lista;
    }

    final configuracion =
        await database.configuracionFiltroDao.getConfiguracionFiltro();
    if (configuracion != null) {
      a.configuracion = Configuracion(
        valorS1: configuracion.valorS1,
        valorS2: configuracion.valorS2,
        valorS3: configuracion.valorS3,
        valorS4: configuracion.valorS4,
        valorS5: configuracion.valorS5,
      );
    }

    a.grupo = Grupo(grupoId: 0, nombre: '');
    a.fechaRegistro = '01/01/0001';
    database.auditoriaDao.insertAuditoriaTask(a);
    return identity;
  }

  @override
  Future<List<Auditoria>> getOffLineSendAuditorias() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    List<Auditoria> data = [];
    final auditorias = await database.auditoriaDao.getAuditorias();

    if (auditorias.isNotEmpty) {
      for (final a in auditorias) {
        a.detalles = await database.detalleDao.getDetallesById(a.auditoriaId);
        a.puntosFijos =
            await database.puntoFijoDao.getPuntoFijoById(a.auditoriaId);
        data.add(a);
      }
    }
    return data;
  }

  @override
  Future<void> deleteOffLineAuditoriaById(int id) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    database.auditoriaDao.deleteAuditoriaById(id);
    database.detalleDao.deleteDetallesById(id);
    database.puntoFijoDao.deletePuntoFijoById(id);
  }

  @override
  Future<AuditoriaOffLine?> getAuditoriaOffLineById(int id) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.auditoriaOffLineDao.getAuditoriaOffLineById(id);
  }

  @override
  Future<void> saveAuditoriaOffLine(AuditoriaOffLine a) async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();

    final getAuditoria = await database.auditoriaOffLineDao
        .getAuditoriaOffLineById(a.auditoriaId);
    if (getAuditoria == null) {
      database.auditoriaOffLineDao.insertAuditoriaOffLineTask(a);
      return;
    }

    getAuditoria.estado = a.estado;
    database.auditoriaOffLineDao.updateAuditoriaOffLineTask(getAuditoria);
  }

  @override
  Future<List<AuditoriaOffLine>> getAuditoriasOffLine() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    return database.auditoriaOffLineDao.getAuditoriasOffLine(1);
  }

  @override
  Future<void> clearTemporaryCheckOffline() async {
    final database =
        await $FloorFlutterDatabase.databaseBuilder(name, pass).build();
    database.auditoriaOffLineDao.deleteAll();
  }
}
