import 'package:divulgacao_atas/data/auth_provider.dart';
import 'package:divulgacao_atas/data/firebase_provider.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:get/get.dart';

class LoginRepository {
  FirebaseProvider firebaseProvider = Get.find();
  AuthProvider authProvider = Get.find();
  Future<List<Campus>> getCampi() {
    return firebaseProvider.getCampi();
  }

  Future<dynamic> criarUsuario(
      String email, String nome, String senha, Campus campus) {
    return authProvider.criarUsuario(email, nome, senha, campus);
  }
}
