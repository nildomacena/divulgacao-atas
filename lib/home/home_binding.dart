import 'package:divulgacao_atas/home/home_controller.dart';
import 'package:divulgacao_atas/home/home_repository.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(HomeRepository()));
  }
}
