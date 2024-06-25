import 'package:floor/floor.dart';
import 'package:app_fivesys/domain/models/offline.dart';

@dao
abstract class OrganizacionFiltroDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrganizacionFiltroTask(List<OrganizacionFiltro> u);

  @Query('SELECT * FROM OrganizacionFiltro')
  Future<List<OrganizacionFiltro>> getOrganizacionFiltro();

  @Query('DELETE FROM OrganizacionFiltro')
  Future<void> deleteAll();
}

@dao
abstract class CategoriaFiltroDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCategoriaFiltroListTask(List<CategoriaFiltro> u);

  @Query('SELECT * FROM CategoriaFiltro')
  Future<List<CategoriaFiltro>> getCategoriaFiltro();

  @Query('DELETE FROM CategoriaFiltro')
  Future<void> deleteAll();
}

@dao
abstract class ConfiguracionFiltroDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertConfiguracionFiltroTask(ConfiguracionFiltro c);

  @Query('SELECT * FROM ConfiguracionFiltro')
  Future<ConfiguracionFiltro?> getConfiguracionFiltro();

  @Query('DELETE FROM ConfiguracionFiltro')
  Future<void> deleteAll();
}
