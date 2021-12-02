import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EscolherCampusPage extends StatelessWidget {
  final List<Campus> campi;
  const EscolherCampusPage(this.campi, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width > 1100 ? 1100 : Get.width,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escolha o campuss'),
        ),
        body: Container(),
      ),
    );
  }
}
