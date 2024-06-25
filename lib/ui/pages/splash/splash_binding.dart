import 'package:get/instance_manager.dart';
import 'package:app_fivesys/ui/pages/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(
        apiRepository: Get.find(),
        localRepository: Get.find(),
      ),
    );
  }
}
