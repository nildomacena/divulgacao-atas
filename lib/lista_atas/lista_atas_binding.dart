import 'package:divulgacao_atas/lista_atas/lista_atas_controller.dart';
import 'package:divulgacao_atas/lista_atas/lista_atas_repository.dart';
import 'package:get/get.dart';

class ListaAtasBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListaAtasController>(
        () => ListaAtasController(ListaAtasRepository()));
  }
}
