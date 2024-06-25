import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
          localRepository: Get.find(),
          apiRepository: Get.find(),
        ));
  }
}
