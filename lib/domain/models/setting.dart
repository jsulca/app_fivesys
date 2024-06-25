import 'package:floor/floor.dart';

@entity
class Setting {
  Setting({
    this.isDarkMode = false,
    this.isOnline = true,
  });
  @primaryKey
  int settingId = 1;
  bool isDarkMode = false;
  bool isOnline = true;
}
