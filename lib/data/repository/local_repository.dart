import 'package:app_fivesys/domain/models/auditoria.dart';
import 'package:app_fivesys/domain/models/offline.dart';
import 'package:app_fivesys/domain/models/usuario.dart';

abstract class LocalRepository {
  Future<void> insertUsuario(Usuario u);
  Future<void> updateUsuario(Usuario u);
  Future<List<Usuario>> getUsuarios();
  Future<Usuario?> getExistUsuario();
  Future<void> deleteAll();
  Future<bool?> isDarkMode();
  Future<bool?> isOnlineMode();
  // ignore: avoid_positional_boolean_parameters
  Future<void> saveDarkMode(bool darkMode);
  Future<void> saveOnlineMode(bool onlineMode);

  Future<void> deleteOffLineAuditoria();
  Future<void> insertAuditoria(Auditoria a);
  Future<Auditoria?> getAuditoriaById(int auditoriaId);
  Future<Auditoria?> getAuditoriaSendById(int auditoriaId);
  Future<void> updateAuditoria(Auditoria? auditoria);

  Future<List<PuntoFijo>> getPuntosFijosById(int id);
  Future<void> updatePuntoFijo(PuntoFijo p);

  Future<List<Detalle>> getDetallesById(int id);
  Future<Detalle?> getDetalleById(int id);
  Future<void> insertDetalle(Detalle d);

  //Filtroline
  Future<void> insertDataOffline(Offline f);
  Future<List<OrganizacionFiltro>> getFiltroOffLine();
  Future<List<Auditoria>> getOfflineAuditorias();
  Future<int> generateAuditoriaOffline(Filtro f);
  Future<List<Auditoria>> getOffLineSendAuditorias();
  Future<void> deleteOffLineAuditoriaById(int id);

  // Ultimo offline
  Future<AuditoriaOffLine?> getAuditoriaOffLineById(int id);
  Future<void> saveAuditoriaOffLine(AuditoriaOffLine a);
  Future<List<AuditoriaOffLine>> getAuditoriasOffLine();

  Future<void> clearTemporaryCheckOffline();
}
