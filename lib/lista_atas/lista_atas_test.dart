import 'package:divulgacao_atas/lista_atas/lista_atas_controller.dart';
import 'package:divulgacao_atas/lista_atas/lista_atas_repository.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:divulgacao_atas/data/auth_provider.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

void main() {
  final AuthProvider authProvider = MockAuthProvider();

  final ListaAtasController controller =
      Get.put(ListaAtasController(ListaAtasRepository()));

  test('Deve chamar dialogo Nova Ata', () {
    controller.novaAta();
    verify<dynamic>(Get.dialog).called(1);
    /* expect(Get.dialog).; */
  });
}
