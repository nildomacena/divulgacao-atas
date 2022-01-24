import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilService {
  void snackBarErro({String? objeto, String? mensagem}) {
    Get.snackbar(
      objeto ?? 'Erro',
      mensagem ?? 'Erro durante a operação',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      maxWidth: 300,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 30),
      duration: const Duration(seconds: 5),
    );
  }

  void snackBar({required String objeto, required String mensagem}) {
    Get.snackbar(
      objeto,
      mensagem,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 30),
      duration: const Duration(seconds: 5),
    );
  }

  Future<void> downloadLink(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void showAlertCarregando([String? mensagem]) {
    Get.dialog(
        AlertDialog(
            content: SizedBox(
                height: 80,
                width: Get.width > 500 ? 500 : Get.width,
                child: Column(children: <Widget>[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      if (kDebugMode) fecharAlert();
                    },
                    child: AutoSizeText(
                      mensagem ?? 'Fazendo consulta...',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Get.theme.primaryColor),
                    ),
                  )
                ]))),
        barrierDismissible: false);
  }

  void fecharAlert() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}

UtilService utilService = UtilService();
