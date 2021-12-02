import 'package:divulgacao_atas/login/login_controller.dart';
import 'package:divulgacao_atas/login/login_repository.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(LoginRepository()));
  }
}
