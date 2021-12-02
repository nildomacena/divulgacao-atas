import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilService {
  void snackBarErro({String? titulo, String? mensagem}) {
    Get.snackbar(
      titulo ?? 'Erro',
      mensagem ?? 'Erro durante a operação',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      maxWidth: 300,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 30),
      duration: const Duration(seconds: 5),
    );
  }
}

UtilService utilService = UtilService();
