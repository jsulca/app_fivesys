import 'package:floor/floor.dart';
import 'package:app_fivesys/domain/models/auditoria.dart';

@dao
abstract class AuditoriaDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAuditoriaTask(Auditoria u);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAuditoriaListTask(List<Auditoria> u);

  @update
  Future<void> updateAuditoriaTask(Auditoria u);

  @delete
  Future<void> deleteAuditoriaTask(Auditoria u);

  @Query('SELECT * FROM Auditoria')
  Future<List<Auditoria>> getAuditorias();

  @Query('SELECT * FROM Auditoria WHERE auditoriaId =:id')
  Future<Auditoria?> getAuditoriaById(int id);

  @Query('DELETE FROM Auditoria WHERE auditoriaId =:id')
  Future<void> deleteAuditoriaById(int id);

  @Query('DELETE FROM Auditoria')
  Future<void> deleteAll();

  @Query('SELECT auditoriaId FROM Auditoria ORDER BY auditoriaId DESC LIMIT 1')
  Future<int?> getAuditoriaIdentity();
}

@dao
abstract class DetalleDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDetalleTask(Detalle d);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDetalleListTask(List<Detalle> d);

  @update
  Future<void> updateDetalleTask(Detalle d);

  @delete
  Future<void> deleteDetalleTask(Detalle d);

  @Query('SELECT * FROM Detalle')
  Future<List<Detalle>> getDetalles();

  @Query('SELECT * FROM Detalle WHERE id =:id')
  Future<Detalle?> getDetalleById(int id);

  @Query('SELECT * FROM Detalle WHERE auditoriaId =:id')
  Future<List<Detalle>> getDetallesById(int id);

  @Query('DELETE FROM Detalle WHERE auditoriaId =:id')
  Future<void> deleteDetallesById(int id);

  @Query('SELECT id FROM Detalle ORDER BY id DESC LIMIT 1')
  Future<int?> getDetalleIdentity();

  @Query('DELETE FROM Detalle')
  Future<void> deleteAll();
}

@dao
abstract class PuntoFijoDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPuntoFijoTask(PuntoFijo p);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPuntoFijoListTask(List<PuntoFijo> p);

  @update
  Future<void> updatePuntoFijoTask(PuntoFijo p);

  @delete
  Future<void> deletePuntoFijoTask(PuntoFijo p);

  @Query('SELECT * FROM PuntoFijo')
  Future<List<PuntoFijo>> getPuntoFijos();

  @Query('SELECT * FROM PuntoFijo WHERE auditoriaId =:id')
  Future<List<PuntoFijo>> getPuntoFijoById(int id);

  @Query('DELETE FROM Detalle WHERE auditoriaId =:id')
  Future<void> deletePuntoFijoById(int id);

  @Query('DELETE FROM PuntoFijo')
  Future<void> deleteAll();
}

@dao
abstract class AuditoriaOffLineDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAuditoriaOffLineTask(AuditoriaOffLine u);

  @update
  Future<void> updateAuditoriaOffLineTask(AuditoriaOffLine u);

  @delete
  Future<void> deleteAuditoriaOffLineTask(AuditoriaOffLine u);

  @Query('SELECT * FROM AuditoriaOffLine WHERE estado =:e')
  Future<List<AuditoriaOffLine>> getAuditoriasOffLine(int e);

  @Query('SELECT * FROM AuditoriaOffLine WHERE auditoriaId =:id')
  Future<AuditoriaOffLine?> getAuditoriaOffLineById(int id);

  @Query('DELETE FROM AuditoriaOffLine')
  Future<void> deleteAll();
}
