import 'package:divulgacao_atas/home/home_binding.dart';
import 'package:divulgacao_atas/home/home_page.dart';
import 'package:divulgacao_atas/lista_atas/lista_atas_binding.dart';
import 'package:divulgacao_atas/lista_atas/lista_atas_page.dart';
import 'package:divulgacao_atas/login/login_binding.dart';
import 'package:divulgacao_atas/login/login_page.dart';
import 'package:get/get.dart';
import 'package:divulgacao_atas/routes/app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: Routes.listaAtas,
        page: () => ListaAtasPage(),
        binding: ListaAtasBinding())
  ];
}
