import 'package:app_fivesys/domain/models/usuario.dart';
import 'package:floor/floor.dart';

@dao
abstract class UsuarioDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUsuarioTask(Usuario u);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUsuarioListTask(List<Usuario> u);

  @update
  Future<void> updateUsuarioTask(Usuario u);

  @delete
  Future<void> deleteUsuarioTask(Usuario u);

  @Query("SELECT * FROM Usuario")
  Future<List<Usuario>> getUsuario();

  @Query("SELECT * FROM Usuario")
  Future<Usuario?> getExistUsuario();

  @Query("DELETE FROM Usuario")
  Future<void> deleteAll();
}
