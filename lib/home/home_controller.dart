import 'package:divulgacao_atas/home/home_repository.dart';
import 'package:get/get.dart';
import 'package:divulgacao_atas/routes/app_routes.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController(this.repository);

  irParaLogin() {
    Get.offAndToNamed(Routes.login);
  }
}
