// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_base.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(
          String name, String password) =>
      _$FlutterDatabaseBuilder(name, password);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null, null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name, this.password);

  final String? name;

  final String? password;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      password,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UsuarioDao? _usuarioDaoInstance;

  SettingDao? _settingDaoInstance;

  AuditoriaDao? _auditoriaDaoInstance;

  DetalleDao? _detalleDaoInstance;

  PuntoFijoDao? _puntoFijoDaoInstance;

  OrganizacionFiltroDao? _organizacionFiltroDaoInstance;

  CategoriaFiltroDao? _categoriaFiltroDaoInstance;

  ConfiguracionFiltroDao? _configuracionFiltroDaoInstance;

  AuditoriaOffLineDao? _auditoriaOffLineDaoInstance;

  Future<sqflite.Database> open(
      String path, String? password, List<Migration> migrations,
      [Callback? callback]) async {
    return sqflite.openDatabase(
      path,
      password: password,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        var batch = database.batch();
        if (startVersion == 2) {
          /*  batch.execute('ALTER TABLE Auditoria ADD online INTEGER');
          batch.execute(
              'CREATE TABLE IF NOT EXISTS `AuditoriaOffLine` (`auditoriaId` INTEGER PRIMARY KEY NOT NULL, `estado` INTEGER NOT NULL)');
          
          batch.execute(
              'ALTER TABLE Detalle ADD auditoriaDetallePadreFotoId INTEGER,pathPadre TEXT NOT NULL');
          batch.execute(
              'CREATE TABLE IF NOT EXISTS `Detalle` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `auditoriaDetalleId` INTEGER NOT NULL, `auditoriaId` INTEGER NOT NULL, `componenteId` INTEGER NOT NULL, `categoriaId` INTEGER NOT NULL, `componente` TEXT, `categoria` TEXT, `aspectoObservado` TEXT, `nombre` TEXT, `s1` INTEGER NOT NULL, `s2` INTEGER NOT NULL, `s3` INTEGER NOT NULL, `s4` INTEGER NOT NULL, `s5` INTEGER NOT NULL, `detalle` TEXT, `fotoId` INTEGER, `url` TEXT NOT NULL, `path` TEXT NOT NULL,`pathPadre` TEXT NOT NULL, `eliminado` INTEGER NOT NULL,`auditoriaDetallePadreId` INTEGER,`auditoriaDetallePadreFotoId` INTEGER,`finalizado` INTEGER NOT NULL)');
          */
        }
        await batch.commit();
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Usuario` (`auditorId` INTEGER NOT NULL, `nombreCompleto` TEXT NOT NULL, `correo` TEXT NOT NULL, `token` TEXT NOT NULL, `cambiarClave` INTEGER NOT NULL, PRIMARY KEY (`auditorId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Setting` (`settingId` INTEGER NOT NULL, `isDarkMode` INTEGER NOT NULL, `isOnline` INTEGER NOT NULL, PRIMARY KEY (`settingId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Auditoria` (`auditoriaId` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `codigo` TEXT NOT NULL, `nombre` TEXT NOT NULL, `estado` INTEGER NOT NULL, `responsableId` INTEGER, `auditorId` INTEGER, `online` INTEGER, `s1` INTEGER NOT NULL, `s2` INTEGER NOT NULL, `s3` INTEGER NOT NULL, `s4` INTEGER NOT NULL, `s5` INTEGER NOT NULL, `fechaRegistro` TEXT, `fechaProgramado` TEXT, `organizacion` TEXT, `responsable` TEXT, `grupo` TEXT, `area` TEXT, `sector` TEXT, `categorias` TEXT, `configuracion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Detalle` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `auditoriaDetalleId` INTEGER NOT NULL, `auditoriaId` INTEGER NOT NULL, `componenteId` INTEGER NOT NULL, `categoriaId` INTEGER NOT NULL, `componente` TEXT, `categoria` TEXT, `aspectoObservado` TEXT, `nombre` TEXT, `s1` INTEGER NOT NULL, `s2` INTEGER NOT NULL, `s3` INTEGER NOT NULL, `s4` INTEGER NOT NULL, `s5` INTEGER NOT NULL, `detalle` TEXT, `fotoId` INTEGER, `url` TEXT NOT NULL, `path` TEXT NOT NULL,`pathPadre` TEXT NOT NULL, `eliminado` INTEGER NOT NULL,`auditoriaDetallePadreId` INTEGER,`auditoriaDetallePadreFotoId` INTEGER,`finalizado` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PuntoFijo` (`auditoriaPuntoFijoId` INTEGER PRIMARY KEY AUTOINCREMENT, `puntoFijoId` INTEGER, `auditoriaId` INTEGER, `nPuntoFijo` TEXT, `fotoId` INTEGER, `url` TEXT NOT NULL, `path` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrganizacionFiltro` (`organizacionId` INTEGER NOT NULL, `nombre` TEXT NOT NULL, `areas` TEXT, PRIMARY KEY (`organizacionId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CategoriaFiltro` (`categoriaId` INTEGER NOT NULL, `nombre` TEXT NOT NULL, `componentes` TEXT, PRIMARY KEY (`categoriaId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ConfiguracionFiltro` (`valorS1` INTEGER NOT NULL, `valorS2` INTEGER NOT NULL, `valorS3` INTEGER NOT NULL, `valorS4` INTEGER NOT NULL, `valorS5` INTEGER NOT NULL, PRIMARY KEY (`valorS1`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AuditoriaOffLine` (`auditoriaId` INTEGER PRIMARY KEY NOT NULL, `estado` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  UsuarioDao get usuarioDao {
    return _usuarioDaoInstance ??= _$UsuarioDao(database, changeListener);
  }

  @override
  SettingDao get settingDao {
    return _settingDaoInstance ??= _$SettingDao(database, changeListener);
  }

  @override
  AuditoriaDao get auditoriaDao {
    return _auditoriaDaoInstance ??= _$AuditoriaDao(database, changeListener);
  }

  @override
  DetalleDao get detalleDao {
    return _detalleDaoInstance ??= _$DetalleDao(database, changeListener);
  }

  @override
  PuntoFijoDao get puntoFijoDao {
    return _puntoFijoDaoInstance ??= _$PuntoFijoDao(database, changeListener);
  }

  @override
  OrganizacionFiltroDao get organizacionFiltroDao {
    return _organizacionFiltroDaoInstance ??=
        _$OrganizacionFiltroDao(database, changeListener);
  }

  @override
  CategoriaFiltroDao get categoriaFiltroDao {
    return _categoriaFiltroDaoInstance ??=
        _$CategoriaFiltroDao(database, changeListener);
  }

  @override
  ConfiguracionFiltroDao get configuracionFiltroDao {
    return _configuracionFiltroDaoInstance ??=
        _$ConfiguracionFiltroDao(database, changeListener);
  }

  @override
  AuditoriaOffLineDao get auditoriaOffLineDao {
    return _auditoriaOffLineDaoInstance ??=
        _$AuditoriaOffLineDao(database, changeListener);
  }
}

class _$UsuarioDao extends UsuarioDao {
  _$UsuarioDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _usuarioInsertionAdapter = InsertionAdapter(
            database,
            'Usuario',
            (Usuario item) => <String, Object?>{
                  'auditorId': item.auditorId,
                  'nombreCompleto': item.nombreCompleto,
                  'correo': item.correo,
                  'token': item.token,
                  'cambiarClave': item.cambiarClave ? 1 : 0
                }),
        _usuarioUpdateAdapter = UpdateAdapter(
            database,
            'Usuario',
            ['auditorId'],
            (Usuario item) => <String, Object?>{
                  'auditorId': item.auditorId,
                  'nombreCompleto': item.nombreCompleto,
                  'correo': item.correo,
                  'token': item.token,
                  'cambiarClave': item.cambiarClave ? 1 : 0
                }),
        _usuarioDeletionAdapter = DeletionAdapter(
            database,
            'Usuario',
            ['auditorId'],
            (Usuario item) => <String, Object?>{
                  'auditorId': item.auditorId,
                  'nombreCompleto': item.nombreCompleto,
                  'correo': item.correo,
                  'token': item.token,
                  'cambiarClave': item.cambiarClave ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usuario> _usuarioInsertionAdapter;

  final UpdateAdapter<Usuario> _usuarioUpdateAdapter;

  final DeletionAdapter<Usuario> _usuarioDeletionAdapter;

  @override
  Future<List<Usuario>> getUsuario() async {
    return _queryAdapter.queryList('SELECT * FROM Usuario',
        mapper: (Map<String, Object?> row) => Usuario(
            auditorId: row['auditorId'] as int,
            nombreCompleto: row['nombreCompleto'] as String,
            correo: row['correo'] as String,
            token: row['token'] as String,
            cambiarClave: (row['cambiarClave'] as int) != 0));
  }

  @override
  Future<Usuario?> getExistUsuario() async {
    return _queryAdapter.query('SELECT * FROM Usuario',
        mapper: (Map<String, Object?> row) => Usuario(
            auditorId: row['auditorId'] as int,
            nombreCompleto: row['nombreCompleto'] as String,
            correo: row['correo'] as String,
            token: row['token'] as String,
            cambiarClave: (row['cambiarClave'] as int) != 0));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Usuario');
  }

  @override
  Future<void> insertUsuarioTask(Usuario u) async {
    await _usuarioInsertionAdapter.insert(u, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertUsuarioListTask(List<Usuario> u) async {
    await _usuarioInsertionAdapter.insertList(u, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateUsuarioTask(Usuario u) async {
    await _usuarioUpdateAdapter.update(u, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUsuarioTask(Usuario u) async {
    await _usuarioDeletionAdapter.delete(u);
  }
}

class _$SettingDao extends SettingDao {
  _$SettingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _settingInsertionAdapter = InsertionAdapter(
            database,
            'Setting',
            (Setting item) => <String, Object?>{
                  'settingId': item.settingId,
                  'isDarkMode': item.isDarkMode ? 1 : 0,
                  'isOnline': item.isOnline ? 1 : 0
                }),
        _settingUpdateAdapter = UpdateAdapter(
            database,
            'Setting',
            ['settingId'],
            (Setting item) => <String, Object?>{
                  'settingId': item.settingId,
                  'isDarkMode': item.isDarkMode ? 1 : 0,
                  'isOnline': item.isOnline ? 1 : 0
                }),
        _settingDeletionAdapter = DeletionAdapter(
            database,
            'Setting',
            ['settingId'],
            (Setting item) => <String, Object?>{
                  'settingId': item.settingId,
                  'isDarkMode': item.isDarkMode ? 1 : 0,
                  'isOnline': item.isOnline ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Setting> _settingInsertionAdapter;

  final UpdateAdapter<Setting> _settingUpdateAdapter;

  final DeletionAdapter<Setting> _settingDeletionAdapter;

  @override
  Future<bool?> getIsDarkMode() async {
    return _queryAdapter.query(
      'SELECT isDarkMode FROM Setting',
      mapper: (Map<String, Object?> row) => (row['isDarkMode'] as int) != 0,
    );
  }

  @override
  Future<bool?> getIsOnlineMode() async {
    return _queryAdapter.query(
      'SELECT isOnline FROM Setting',
      mapper: (Map<String, Object?> row) => (row['isOnline'] as int) != 0,
    );
  }

  @override
  Future<void> insertSettingTask(Setting u) async {
    await _settingInsertionAdapter.insert(u, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateSettingTask(Setting u) async {
    await _settingUpdateAdapter.update(u, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSettingTask(Setting u) async {
    await _settingDeletionAdapter.delete(u);
  }
}

class _$AuditoriaDao extends AuditoriaDao {
  _$AuditoriaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _auditoriaInsertionAdapter = InsertionAdapter(
            database,
            'Auditoria',
            (Auditoria item) => <String, Object?>{
                  'auditoriaId': item.auditoriaId,
                  'codigo': item.codigo,
                  'nombre': item.nombre,
                  'estado': item.estado,
                  'responsableId': item.responsableId,
                  'auditorId': item.auditorId,
                  'online': item.online,
                  's1': item.s1 ? 1 : 0,
                  's2': item.s2 ? 1 : 0,
                  's3': item.s3 ? 1 : 0,
                  's4': item.s4 ? 1 : 0,
                  's5': item.s5 ? 1 : 0,
                  'fechaRegistro': item.fechaRegistro,
                  'fechaProgramado': item.fechaProgramado,
                  'organizacion':
                      _organizacionConverter.encode(item.organizacion),
                  'responsable': _responsableConverter.encode(item.responsable),
                  'grupo': _grupoConverter.encode(item.grupo),
                  'area': _areaConverter.encode(item.area),
                  'sector': _sectorConverter.encode(item.sector),
                  'categorias':
                      _listCategoriaElementConverter.encode(item.categorias),
                  'configuracion':
                      _configuracionConverter.encode(item.configuracion)
                }),
        _auditoriaUpdateAdapter = UpdateAdapter(
            database,
            'Auditoria',
            ['auditoriaId'],
            (Auditoria item) => <String, Object?>{
                  'auditoriaId': item.auditoriaId,
                  'codigo': item.codigo,
                  'nombre': item.nombre,
                  'estado': item.estado,
                  'responsableId': item.responsableId,
                  'auditorId': item.auditorId,
                  'online': item.online,
                  's1': item.s1 ? 1 : 0,
                  's2': item.s2 ? 1 : 0,
                  's3': item.s3 ? 1 : 0,
                  's4': item.s4 ? 1 : 0,
                  's5': item.s5 ? 1 : 0,
                  'fechaRegistro': item.fechaRegistro,
                  'fechaProgramado': item.fechaProgramado,
                  'organizacion':
                      _organizacionConverter.encode(item.organizacion),
                  'responsable': _responsableConverter.encode(item.responsable),
                  'grupo': _grupoConverter.encode(item.grupo),
                  'area': _areaConverter.encode(item.area),
                  'sector': _sectorConverter.encode(item.sector),
                  'categorias':
                      _listCategoriaElementConverter.encode(item.categorias),
                  'configuracion':
                      _configuracionConverter.encode(item.configuracion)
                }),
        _auditoriaDeletionAdapter = DeletionAdapter(
            database,
            'Auditoria',
            ['auditoriaId'],
            (Auditoria item) => <String, Object?>{
                  'auditoriaId': item.auditoriaId,
                  'codigo': item.codigo,
                  'nombre': item.nombre,
                  'estado': item.estado,
                  'responsableId': item.responsableId,
                  'auditorId': item.auditorId,
                  'online': item.online,
                  's1': item.s1 ? 1 : 0,
                  's2': item.s2 ? 1 : 0,
                  's3': item.s3 ? 1 : 0,
                  's4': item.s4 ? 1 : 0,
                  's5': item.s5 ? 1 : 0,
                  'fechaRegistro': item.fechaRegistro,
                  'fechaProgramado': item.fechaProgramado,
                  'organizacion':
                      _organizacionConverter.encode(item.organizacion),
                  'responsable': _responsableConverter.encode(item.responsable),
                  'grupo': _grupoConverter.encode(item.grupo),
                  'area': _areaConverter.encode(item.area),
                  'sector': _sectorConverter.encode(item.sector),
                  'categorias':
                      _listCategoriaElementConverter.encode(item.categorias),
                  'configuracion':
                      _configuracionConverter.encode(item.configuracion)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Auditoria> _auditoriaInsertionAdapter;

  final UpdateAdapter<Auditoria> _auditoriaUpdateAdapter;

  final DeletionAdapter<Auditoria> _auditoriaDeletionAdapter;

  @override
  Future<List<Auditoria>> getAuditorias() async {
    return _queryAdapter.queryList('SELECT * FROM Auditoria',
        mapper: (Map<String, Object?> row) => Auditoria(
            auditoriaId: row['auditoriaId'] as int,
            codigo: row['codigo'] as String,
            nombre: row['nombre'] as String,
            estado: row['estado'] as int,
            responsableId: row['responsableId'] as int?,
            auditorId: row['auditorId'] as int?,
            s1: (row['s1'] as int) != 0,
            s2: (row['s2'] as int) != 0,
            s3: (row['s3'] as int) != 0,
            s4: (row['s4'] as int) != 0,
            s5: (row['s5'] as int) != 0,
            fechaRegistro: row['fechaRegistro'] as String?,
            fechaProgramado: row['fechaProgramado'] as String?,
            organizacion:
                _organizacionConverter.decode(row['organizacion'] as String),
            responsable:
                _responsableConverter.decode(row['responsable'] as String),
            grupo: _grupoConverter.decode(row['grupo'] as String),
            area: _areaConverter.decode(row['area'] as String),
            sector: _sectorConverter.decode(row['sector'] as String),
            categorias: _listCategoriaElementConverter
                .decode(row['categorias'] as String),
            configuracion:
                _configuracionConverter.decode(row['configuracion'] as String),
            online: row['online'] as int?));
  }

  @override
  Future<Auditoria?> getAuditoriaById(int id) async {
    return _queryAdapter.query('SELECT * FROM Auditoria WHERE auditoriaId =?1',
        mapper: (Map<String, Object?> row) => Auditoria(
            auditoriaId: row['auditoriaId'] as int,
            codigo: row['codigo'] as String,
            nombre: row['nombre'] as String,
            estado: row['estado'] as int,
            responsableId: row['responsableId'] as int?,
            auditorId: row['auditorId'] as int?,
            s1: (row['s1'] as int) != 0,
            s2: (row['s2'] as int) != 0,
            s3: (row['s3'] as int) != 0,
            s4: (row['s4'] as int) != 0,
            s5: (row['s5'] as int) != 0,
            fechaRegistro: row['fechaRegistro'] as String?,
            fechaProgramado: row['fechaProgramado'] as String?,
            organizacion:
                _organizacionConverter.decode(row['organizacion'] as String),
            responsable:
                _responsableConverter.decode(row['responsable'] as String),
            grupo: _grupoConverter.decode(row['grupo'] as String),
            area: _areaConverter.decode(row['area'] as String),
            sector: _sectorConverter.decode(row['sector'] as String),
            categorias: _listCategoriaElementConverter
                .decode(row['categorias'] as String),
            configuracion:
                _configuracionConverter.decode(row['configuracion'] as String),
            online: row['online'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAuditoriaById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM Auditoria WHERE auditoriaId =?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Auditoria');
  }

  @override
  Future<int?> getAuditoriaIdentity() async {
    return _queryAdapter.query(
      'SELECT auditoriaId FROM Auditoria ORDER BY auditoriaId DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row['auditoriaId'] as int,
    );
  }

  @override
  Future<void> insertAuditoriaTask(Auditoria u) async {
    await _auditoriaInsertionAdapter.insert(u, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAuditoriaListTask(List<Auditoria> u) async {
    await _auditoriaInsertionAdapter.insertList(u, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAuditoriaTask(Auditoria u) async {
    await _auditoriaUpdateAdapter.update(u, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAuditoriaTask(Auditoria u) async {
    await _auditoriaDeletionAdapter.delete(u);
  }
}

class _$DetalleDao extends DetalleDao {
  _$DetalleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _detalleInsertionAdapter = InsertionAdapter(
            database,
            'Detalle',
            (Detalle item) => <String, Object?>{
                  'id': item.id,
                  'auditoriaDetalleId': item.auditoriaDetalleId,
                  'auditoriaId': item.auditoriaId,
                  'componenteId': item.componenteId,
                  'categoriaId': item.categoriaId,
                  'componente':
                      _detalleComponenteConvert.encode(item.componente),
                  'categoria': _detalleCategoriaConvert.encode(item.categoria),
                  'aspectoObservado': item.aspectoObservado,
                  'nombre': item.nombre,
                  's1': item.s1,
                  's2': item.s2,
                  's3': item.s3,
                  's4': item.s4,
                  's5': item.s5,
                  'detalle': item.detalle,
                  'fotoId': item.fotoId,
                  'url': item.url,
                  'path': item.path,
                  'pathPadre': item.pathPadre,
                  'eliminado': item.eliminado ? 1 : 0,
                  'auditoriaDetallePadreId': item.auditoriaDetallePadreId,
                  'auditoriaDetallePadreFotoId':
                      item.auditoriaDetallePadreFotoId,
                  'finalizado': item.finalizado ? 1 : 0
                }),
        _detalleUpdateAdapter = UpdateAdapter(
            database,
            'Detalle',
            ['id'],
            (Detalle item) => <String, Object?>{
                  'id': item.id,
                  'auditoriaDetalleId': item.auditoriaDetalleId,
                  'auditoriaId': item.auditoriaId,
                  'componenteId': item.componenteId,
                  'categoriaId': item.categoriaId,
                  'componente':
                      _detalleComponenteConvert.encode(item.componente),
                  'categoria': _detalleCategoriaConvert.encode(item.categoria),
                  'aspectoObservado': item.aspectoObservado,
                  'nombre': item.nombre,
                  's1': item.s1,
                  's2': item.s2,
                  's3': item.s3,
                  's4': item.s4,
                  's5': item.s5,
                  'detalle': item.detalle,
                  'fotoId': item.fotoId,
                  'url': item.url,
                  'path': item.path,
                  'pathPadre': item.pathPadre,
                  'eliminado': item.eliminado ? 1 : 0,
                  'auditoriaDetallePadreId': item.auditoriaDetallePadreId,
                  'auditoriaDetallePadreFotoId':
                      item.auditoriaDetallePadreFotoId,
                  'finalizado': item.finalizado ? 1 : 0
                }),
        _detalleDeletionAdapter = DeletionAdapter(
            database,
            'Detalle',
            ['id'],
            (Detalle item) => <String, Object?>{
                  'id': item.id,
                  'auditoriaDetalleId': item.auditoriaDetalleId,
                  'auditoriaId': item.auditoriaId,
                  'componenteId': item.componenteId,
                  'categoriaId': item.categoriaId,
                  'componente':
                      _detalleComponenteConvert.encode(item.componente),
                  'categoria': _detalleCategoriaConvert.encode(item.categoria),
                  'aspectoObservado': item.aspectoObservado,
                  'nombre': item.nombre,
                  's1': item.s1,
                  's2': item.s2,
                  's3': item.s3,
                  's4': item.s4,
                  's5': item.s5,
                  'detalle': item.detalle,
                  'fotoId': item.fotoId,
                  'url': item.url,
                  'path': item.path,
                  'pathPadre': item.pathPadre,
                  'eliminado': item.eliminado ? 1 : 0,
                  'auditoriaDetallePadreId': item.auditoriaDetallePadreId,
                  'auditoriaDetallePadreFotoId':
                      item.auditoriaDetallePadreFotoId,
                  'finalizado': item.finalizado ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Detalle> _detalleInsertionAdapter;

  final UpdateAdapter<Detalle> _detalleUpdateAdapter;

  final DeletionAdapter<Detalle> _detalleDeletionAdapter;

  @override
  Future<List<Detalle>> getDetalles() async {
    return _queryAdapter.queryList('SELECT * FROM Detalle',
        mapper: (Map<String, Object?> row) => Detalle(
              id: row['id'] as int,
              auditoriaDetalleId: row['auditoriaDetalleId'] as int,
              auditoriaId: row['auditoriaId'] as int,
              componenteId: row['componenteId'] as int,
              categoriaId: row['categoriaId'] as int,
              componente:
                  _detalleComponenteConvert.decode(row['componente'] as String),
              categoria:
                  _detalleCategoriaConvert.decode(row['categoria'] as String),
              aspectoObservado: row['aspectoObservado'] as String?,
              nombre: row['nombre'] as String?,
              s1: row['s1'] as int,
              s2: row['s2'] as int,
              s3: row['s3'] as int,
              s4: row['s4'] as int,
              s5: row['s5'] as int,
              detalle: row['detalle'] as String?,
              fotoId: row['fotoId'] as int?,
              url: row['url'] as String,
              path: row['path'] as String,
              pathPadre: row['pathPadre'] as String,
              eliminado: (row['eliminado'] as int) != 0,
              auditoriaDetallePadreId: row['auditoriaDetallePadreId'] as int?,
              auditoriaDetallePadreFotoId:
                  row['auditoriaDetallePadreFotoId'] as int?,
              finalizado: (row['finalizado'] as int) != 0,
            ));
  }

  @override
  Future<Detalle?> getDetalleById(int id) async {
    return _queryAdapter.query('SELECT * FROM Detalle WHERE id =?1',
        mapper: (Map<String, Object?> row) => Detalle(
              id: row['id'] as int,
              auditoriaDetalleId: row['auditoriaDetalleId'] as int,
              auditoriaId: row['auditoriaId'] as int,
              componenteId: row['componenteId'] as int,
              categoriaId: row['categoriaId'] as int,
              componente:
                  _detalleComponenteConvert.decode(row['componente'] as String),
              categoria:
                  _detalleCategoriaConvert.decode(row['categoria'] as String),
              aspectoObservado: row['aspectoObservado'] as String?,
              nombre: row['nombre'] as String?,
              s1: row['s1'] as int,
              s2: row['s2'] as int,
              s3: row['s3'] as int,
              s4: row['s4'] as int,
              s5: row['s5'] as int,
              detalle: row['detalle'] as String?,
              fotoId: row['fotoId'] as int?,
              url: row['url'] as String,
              path: row['path'] as String,
              pathPadre: row['pathPadre'] as String,
              eliminado: (row['eliminado'] as int) != 0,
              auditoriaDetallePadreId: row['auditoriaDetallePadreId'] as int?,
              auditoriaDetallePadreFotoId:
                  row['auditoriaDetallePadreFotoId'] as int?,
              finalizado: (row['finalizado'] as int) != 0,
            ),
        arguments: [id]);
  }

  @override
  Future<List<Detalle>> getDetallesById(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Detalle WHERE auditoriaId =?1',
        mapper: (Map<String, Object?> row) => Detalle(
              id: row['id'] as int,
              auditoriaDetalleId: row['auditoriaDetalleId'] as int,
              auditoriaId: row['auditoriaId'] as int,
              componenteId: row['componenteId'] as int,
              categoriaId: row['categoriaId'] as int,
              componente:
                  _detalleComponenteConvert.decode(row['componente'] as String),
              categoria:
                  _detalleCategoriaConvert.decode(row['categoria'] as String),
              aspectoObservado: row['aspectoObservado'] as String?,
              nombre: row['nombre'] as String?,
              s1: row['s1'] as int,
              s2: row['s2'] as int,
              s3: row['s3'] as int,
              s4: row['s4'] as int,
              s5: row['s5'] as int,
              detalle: row['detalle'] as String?,
              fotoId: row['fotoId'] as int?,
              url: row['url'] as String,
              path: row['path'] as String,
              pathPadre: row['pathPadre'] as String,
              eliminado: (row['eliminado'] as int) != 0,
              auditoriaDetallePadreId: row['auditoriaDetallePadreId'] as int?,
              auditoriaDetallePadreFotoId:
                  row['auditoriaDetallePadreFotoId'] as int?,
              finalizado: (row['finalizado'] as int) != 0,
            ),
        arguments: [id]);
  }

  @override
  Future<void> deleteDetallesById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM Detalle WHERE auditoriaId =?1',
        arguments: [id]);
  }

  @override
  Future<int?> getDetalleIdentity() async {
    return _queryAdapter.query(
      'SELECT id FROM Detalle ORDER BY id DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row['id'] as int,
    );
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Detalle');
  }

  @override
  Future<void> insertDetalleTask(Detalle d) async {
    await _detalleInsertionAdapter.insert(d, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertDetalleListTask(List<Detalle> d) async {
    await _detalleInsertionAdapter.insertList(d, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateDetalleTask(Detalle d) async {
    await _detalleUpdateAdapter.update(d, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDetalleTask(Detalle d) async {
    await _detalleDeletionAdapter.delete(d);
  }
}

class _$PuntoFijoDao extends PuntoFijoDao {
  _$PuntoFijoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _puntoFijoInsertionAdapter = InsertionAdapter(
            database,
            'PuntoFijo',
            (PuntoFijo item) => <String, Object?>{
                  'auditoriaPuntoFijoId': item.auditoriaPuntoFijoId,
                  'puntoFijoId': item.puntoFijoId,
                  'auditoriaId': item.auditoriaId,
                  'nPuntoFijo': item.nPuntoFijo,
                  'fotoId': item.fotoId,
                  'url': item.url,
                  'path': item.path
                }),
        _puntoFijoUpdateAdapter = UpdateAdapter(
            database,
            'PuntoFijo',
            ['auditoriaPuntoFijoId'],
            (PuntoFijo item) => <String, Object?>{
                  'auditoriaPuntoFijoId': item.auditoriaPuntoFijoId,
                  'puntoFijoId': item.puntoFijoId,
                  'auditoriaId': item.auditoriaId,
                  'nPuntoFijo': item.nPuntoFijo,
                  'fotoId': item.fotoId,
                  'url': item.url,
                  'path': item.path
                }),
        _puntoFijoDeletionAdapter = DeletionAdapter(
            database,
            'PuntoFijo',
            ['auditoriaPuntoFijoId'],
            (PuntoFijo item) => <String, Object?>{
                  'auditoriaPuntoFijoId': item.auditoriaPuntoFijoId,
                  'puntoFijoId': item.puntoFijoId,
                  'auditoriaId': item.auditoriaId,
                  'nPuntoFijo': item.nPuntoFijo,
                  'fotoId': item.fotoId,
                  'url': item.url,
                  'path': item.path
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PuntoFijo> _puntoFijoInsertionAdapter;

  final UpdateAdapter<PuntoFijo> _puntoFijoUpdateAdapter;

  final DeletionAdapter<PuntoFijo> _puntoFijoDeletionAdapter;

  @override
  Future<List<PuntoFijo>> getPuntoFijos() async {
    return _queryAdapter.queryList('SELECT * FROM PuntoFijo',
        mapper: (Map<String, Object?> row) => PuntoFijo(
            auditoriaPuntoFijoId: row['auditoriaPuntoFijoId'] as int?,
            puntoFijoId: row['puntoFijoId'] as int?,
            auditoriaId: row['auditoriaId'] as int?,
            nPuntoFijo: row['nPuntoFijo'] as String?,
            fotoId: row['fotoId'] as int?,
            url: row['url'] as String,
            path: row['path'] as String));
  }

  @override
  Future<List<PuntoFijo>> getPuntoFijoById(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PuntoFijo WHERE auditoriaId =?1',
        mapper: (Map<String, Object?> row) => PuntoFijo(
            auditoriaPuntoFijoId: row['auditoriaPuntoFijoId'] as int?,
            puntoFijoId: row['puntoFijoId'] as int?,
            auditoriaId: row['auditoriaId'] as int?,
            nPuntoFijo: row['nPuntoFijo'] as String?,
            fotoId: row['fotoId'] as int?,
            url: row['url'] as String,
            path: row['path'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deletePuntoFijoById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM Detalle WHERE auditoriaId =?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PuntoFijo');
  }

  @override
  Future<void> insertPuntoFijoTask(PuntoFijo p) async {
    await _puntoFijoInsertionAdapter.insert(p, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPuntoFijoListTask(List<PuntoFijo> p) async {
    await _puntoFijoInsertionAdapter.insertList(p, OnConflictStrategy.replace);
  }

  @override
  Future<void> updatePuntoFijoTask(PuntoFijo p) async {
    await _puntoFijoUpdateAdapter.update(p, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePuntoFijoTask(PuntoFijo p) async {
    await _puntoFijoDeletionAdapter.delete(p);
  }
}

class _$OrganizacionFiltroDao extends OrganizacionFiltroDao {
  _$OrganizacionFiltroDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _organizacionFiltroInsertionAdapter = InsertionAdapter(
            database,
            'OrganizacionFiltro',
            (OrganizacionFiltro item) => <String, Object?>{
                  'organizacionId': item.organizacionId,
                  'nombre': item.nombre,
                  'areas': _areaFiltroConverter.encode(item.areas)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrganizacionFiltro>
      _organizacionFiltroInsertionAdapter;

  @override
  Future<List<OrganizacionFiltro>> getOrganizacionFiltro() async {
    return _queryAdapter.queryList('SELECT * FROM OrganizacionFiltro',
        mapper: (Map<String, Object?> row) => OrganizacionFiltro(
            organizacionId: row['organizacionId'] as int,
            nombre: row['nombre'] as String,
            areas: _areaFiltroConverter.decode(row['areas'] as String)));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM OrganizacionFiltro');
  }

  @override
  Future<void> insertOrganizacionFiltroTask(List<OrganizacionFiltro> u) async {
    await _organizacionFiltroInsertionAdapter.insertList(
        u, OnConflictStrategy.replace);
  }
}

class _$CategoriaFiltroDao extends CategoriaFiltroDao {
  _$CategoriaFiltroDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _categoriaFiltroInsertionAdapter = InsertionAdapter(
            database,
            'CategoriaFiltro',
            (CategoriaFiltro item) => <String, Object?>{
                  'categoriaId': item.categoriaId,
                  'nombre': item.nombre,
                  'componentes':
                      _componenteFiltroConverter.encode(item.componentes)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoriaFiltro> _categoriaFiltroInsertionAdapter;

  @override
  Future<List<CategoriaFiltro>> getCategoriaFiltro() async {
    return _queryAdapter.queryList('SELECT * FROM CategoriaFiltro',
        mapper: (Map<String, Object?> row) => CategoriaFiltro(
            categoriaId: row['categoriaId'] as int,
            nombre: row['nombre'] as String,
            componentes: _componenteFiltroConverter
                .decode(row['componentes'] as String)));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM CategoriaFiltro');
  }

  @override
  Future<void> insertCategoriaFiltroListTask(List<CategoriaFiltro> u) async {
    await _categoriaFiltroInsertionAdapter.insertList(
        u, OnConflictStrategy.replace);
  }
}

class _$ConfiguracionFiltroDao extends ConfiguracionFiltroDao {
  _$ConfiguracionFiltroDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _configuracionFiltroInsertionAdapter = InsertionAdapter(
            database,
            'ConfiguracionFiltro',
            (ConfiguracionFiltro item) => <String, Object?>{
                  'valorS1': item.valorS1,
                  'valorS2': item.valorS2,
                  'valorS3': item.valorS3,
                  'valorS4': item.valorS4,
                  'valorS5': item.valorS5
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ConfiguracionFiltro>
      _configuracionFiltroInsertionAdapter;

  @override
  Future<ConfiguracionFiltro?> getConfiguracionFiltro() async {
    return _queryAdapter.query('SELECT * FROM ConfiguracionFiltro',
        mapper: (Map<String, Object?> row) => ConfiguracionFiltro(
            valorS1: row['valorS1'] as int,
            valorS2: row['valorS2'] as int,
            valorS3: row['valorS3'] as int,
            valorS4: row['valorS4'] as int,
            valorS5: row['valorS5'] as int));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ConfiguracionFiltro');
  }

  @override
  Future<void> insertConfiguracionFiltroTask(ConfiguracionFiltro c) async {
    await _configuracionFiltroInsertionAdapter.insert(
        c, OnConflictStrategy.replace);
  }
}

class _$AuditoriaOffLineDao extends AuditoriaOffLineDao {
  _$AuditoriaOffLineDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _auditoriaOffLineInsertionAdapter = InsertionAdapter(
            database,
            'AuditoriaOffLine',
            (AuditoriaOffLine item) => <String, Object?>{
                  'auditoriaId': item.auditoriaId,
                  'estado': item.estado
                }),
        _auditoriaOffLineUpdateAdapter = UpdateAdapter(
            database,
            'AuditoriaOffLine',
            ['auditoriaId'],
            (AuditoriaOffLine item) => <String, Object?>{
                  'auditoriaId': item.auditoriaId,
                  'estado': item.estado
                }),
        _auditoriaOffLineDeletionAdapter = DeletionAdapter(
            database,
            'AuditoriaOffLine',
            ['auditoriaId'],
            (AuditoriaOffLine item) => <String, Object?>{
                  'auditoriaId': item.auditoriaId,
                  'estado': item.estado
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AuditoriaOffLine> _auditoriaOffLineInsertionAdapter;

  final UpdateAdapter<AuditoriaOffLine> _auditoriaOffLineUpdateAdapter;

  final DeletionAdapter<AuditoriaOffLine> _auditoriaOffLineDeletionAdapter;

  @override
  Future<List<AuditoriaOffLine>> getAuditoriasOffLine(int e) async {
    return _queryAdapter.queryList(
        'SELECT * FROM AuditoriaOffLine WHERE estado =?1',
        mapper: (Map<String, Object?> row) => AuditoriaOffLine(
            auditoriaId: row['auditoriaId'] as int,
            estado: row['estado'] as int),
        arguments: [e]);
  }

  @override
  Future<AuditoriaOffLine?> getAuditoriaOffLineById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM AuditoriaOffLine WHERE auditoriaId =?1',
        mapper: (Map<String, Object?> row) => AuditoriaOffLine(
            auditoriaId: row['auditoriaId'] as int,
            estado: row['estado'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM AuditoriaOffLine');
  }

  @override
  Future<void> insertAuditoriaOffLineTask(AuditoriaOffLine u) async {
    await _auditoriaOffLineInsertionAdapter.insert(
        u, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAuditoriaOffLineTask(AuditoriaOffLine u) async {
    await _auditoriaOffLineUpdateAdapter.update(u, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAuditoriaOffLineTask(AuditoriaOffLine u) async {
    await _auditoriaOffLineDeletionAdapter.delete(u);
  }
}

// ignore_for_file: unused_element
final _sectorConverter = SectorConverter();
final _organizacionConverter = OrganizacionConverter();
final _areaConverter = AreaConverter();
final _grupoConverter = GrupoConverter();
final _responsableConverter = ResponsableConverter();
final _listCategoriaElementConverter = ListCategoriaElementConverter();
final _configuracionConverter = ConfiguracionConverter();
final _detalleComponenteConvert = DetalleComponenteConvert();
final _detalleCategoriaConvert = DetalleCategoriaConvert();
final _areaFiltroConverter = AreaFiltroConverter();
final _componenteFiltroConverter = ComponenteFiltroConverter();
