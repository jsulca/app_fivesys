import 'package:get/instance_manager.dart';
import 'auditoria_controller.dart';

class AuditoriaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuditoriaController(
          apiRepository: Get.find(), localRepository: Get.find()),
    );
  }
}
