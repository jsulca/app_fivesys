import 'package:app_fivesys/domain/models/setting.dart';
import 'package:floor/floor.dart';

@dao
abstract class SettingDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSettingTask(Setting u);

  @update
  Future<void> updateSettingTask(Setting u);

  @delete
  Future<void> deleteSettingTask(Setting u);

  @Query("SELECT isDarkMode FROM Setting")
  Future<bool?> getIsDarkMode();

  @Query("SELECT isOnline FROM Setting")
  Future<bool?> getIsOnlineMode();
}
