import 'package:divulgacao_atas/data/auth_provider.dart';
import 'package:divulgacao_atas/data/firebase_provider.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseProvider(), permanent: true);
    Get.put(AuthProvider(), permanent: true);
  }
}
