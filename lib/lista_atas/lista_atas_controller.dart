import 'package:divulgacao_atas/lista_atas/dialog_nova_ata/dialog_nova_ata_page.dart';
import 'package:divulgacao_atas/lista_atas/lista_atas_repository.dart';
import 'package:divulgacao_atas/model/ata_model.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:divulgacao_atas/routes/app_routes.dart';
import 'package:divulgacao_atas/services/util_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ListaAtasController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final RxBool _autenticado = RxBool(false);
  final ListaAtasRepository repository;
  final RxList<Ata> _atas = RxList();
  final RxBool _filtroSelecionado = RxBool(false);
  bool carregando = true;
  //List<Ata> atas = [];
  List<Campus> campi = [];
  Campus? campusSelecionado;
  TextEditingController objetoInputController = TextEditingController();
  bool get autenticado => _autenticado.value;

  List<Ata> get atas => filtraAtas();
  bool get filtroSelecionado => _filtroSelecionado.value;
  ListaAtasController(this.repository) {
    _autenticado.bindStream(
        _firebaseAuth.authStateChanges().map((user) => user != null));

    repository.getCampi().then((campi) {
      this.campi = campi;
      update();
    });

    objetoInputController.addListener(() {
      print(objetoInputController.text);
      update();
    });
  }

  @override
  void onInit() async {
    _filtroSelecionado.bindStream(_atas.stream.map((atas) =>
        objetoInputController.text.isNotEmpty || campusSelecionado != null));
    update();
    getAtas();
    // novaAta();
    super.onInit();
  }

  List<Ata> filtraAtas() {
    if (objetoInputController.text.isEmpty) return _atas.toList();

    return _atas
        .toList()
        .where((ata) =>
            ata.objeto
                .toLowerCase()
                .contains(objetoInputController.text.toLowerCase()) ||
            ata.pregao
                .toLowerCase()
                .contains(objetoInputController.text.toLowerCase()))
        .toList();
  }

  getAtas([Campus? campus]) async {
    _atas.bindStream(repository.streamAtas(campus));
    await Future.delayed(const Duration(seconds: 1));
    carregando = false;
    update();
  }

  downloadLink(String url) {
    utilService.downloadLink(url);
  }

  novaAta() {
    Get.dialog(DialogNovaAtaPage());
  }

  irParaLogin() {
    Get.toNamed(Routes.login);
  }

  escolherCampus(Campus campus) {
    campusSelecionado = campus;
    getAtas(campus);
    update();
  }

  limparFiltros() {
    campusSelecionado = null;
    objetoInputController.text = '';
    getAtas();
    update();
  }

  logout() async {
    try {
      await repository.logout();
    } catch (e) {
      utilService.snackBarErro();
    }
  }
}
