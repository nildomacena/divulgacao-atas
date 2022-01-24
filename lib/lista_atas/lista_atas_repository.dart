import 'dart:typed_data';

import 'package:divulgacao_atas/data/auth_provider.dart';
import 'package:divulgacao_atas/data/firebase_provider.dart';
import 'package:divulgacao_atas/model/ata_model.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:divulgacao_atas/model/usuario_model.dart';
import 'package:get/get.dart';

class ListaAtasRepository {
  AuthProvider authProvider = Get.find();
  FirebaseProvider firebaseProvider = Get.find();

  Future<dynamic> salvarAta(
      String pregao,
      String objeto,
      DateTime vigencia,
      Uint8List relacaoItens,
      String relacaoItensFileName,
      Uint8List resultadosFornecedor,
      String resultadosFornecedorFileName) {
    return firebaseProvider.salvarAnuncio(
        pregao,
        objeto,
        vigencia,
        relacaoItens,
        relacaoItensFileName,
        resultadosFornecedor,
        resultadosFornecedorFileName);
  }

  Usuario? getUsuarioLogado() {
    return firebaseProvider.usuario;
  }

  Future<void> logout() {
    return authProvider.logout();
  }

  Future<List<Campus>> getCampi() {
    return firebaseProvider.getCampi();
  }

  Future<List<Ata>> getAtas([Campus? campus]) {
    return firebaseProvider.getAtas(campus);
  }

  Stream<List<Ata>> streamAtas(Campus? campus) {
    return firebaseProvider.streamAtas(campus);
  }
}
