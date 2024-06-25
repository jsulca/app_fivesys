import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite_sqlcipher/sqflite.dart' as sqflite;

import 'dao/auditoria_dao.dart';
import 'dao/offline_dao.dart';
import 'dao/setting_dao.dart';
import 'dao/usuario_dao.dart';
import 'models/auditoria.dart';

import 'models/convert.dart';
import 'models/offline.dart';
import 'models/setting.dart';
import 'models/usuario.dart';

part 'app_data_base.g.dart';

/* 
# Para generar nuevamente database floor
# flutter clean
# flutter pub get
# flutter packages pub run build_runner build --delete-conflicting-outputs
*/

@TypeConverters([
  SectorConverter,
  OrganizacionConverter,
  AreaConverter,
  GrupoConverter,
  ResponsableConverter,
  ListCategoriaElementConverter,
  ConfiguracionConverter,
  DetalleComponenteConvert,
  DetalleCategoriaConvert,
  AreaFiltroConverter,
  ComponenteFiltroConverter,
])
@Database(
  entities: [
    Usuario,
    Setting,
    Auditoria,
    Detalle,
    PuntoFijo,
    OrganizacionFiltro,
    CategoriaFiltro,
    ConfiguracionFiltro,
    AuditoriaOffLine,
  ],
  version: 2, // version 1 en play store
)
abstract class FlutterDatabase extends FloorDatabase {
  UsuarioDao get usuarioDao;
  SettingDao get settingDao;
  AuditoriaDao get auditoriaDao;
  DetalleDao get detalleDao;
  PuntoFijoDao get puntoFijoDao;
  OrganizacionFiltroDao get organizacionFiltroDao;
  CategoriaFiltroDao get categoriaFiltroDao;
  ConfiguracionFiltroDao get configuracionFiltroDao;
  AuditoriaOffLineDao get auditoriaOffLineDao;
}
