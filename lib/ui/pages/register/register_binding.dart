import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:app_fivesys/ui/pages/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterController(
          apiRepository: Get.find(), localRepository: Get.find()),
    );
  }
}
