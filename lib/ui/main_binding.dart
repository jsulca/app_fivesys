import 'package:get/instance_manager.dart';

import 'package:app_fivesys/data/datasource/api_repository_impl.dart';
import 'package:app_fivesys/data/datasource/local_repository_impl.dart';
import 'package:app_fivesys/data/repository/api_repository.dart';
import 'package:app_fivesys/data/repository/local_repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalRepository>(() => LocalRepositoryImpl());
    Get.lazyPut<ApiRepository>(() => ApiRepositoryImpl());
  }
}
