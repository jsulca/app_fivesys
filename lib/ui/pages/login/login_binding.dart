import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:app_fivesys/ui/pages/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(
          apiRepository: Get.find(), localRepository: Get.find()),
    );
  }
}
