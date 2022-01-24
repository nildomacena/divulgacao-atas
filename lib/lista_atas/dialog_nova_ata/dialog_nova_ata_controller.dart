import 'dart:typed_data';
import 'package:divulgacao_atas/lista_atas/lista_atas_controller.dart';
import 'package:divulgacao_atas/services/util_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogNovaAtaController extends GetxController {
  ListaAtasController listaAtasController = Get.find();
  DateTime? vigencia;

  Uint8List? relacaoItensFileBytes;
  String? relacaoItensFileName;

  Uint8List? resultadosFornecedorFileBytes;
  String? resultadosFornecedorFileName;

  TextEditingController pregaoController = TextEditingController();
  TextEditingController objetoController = TextEditingController();

  bool get formValido =>
      relacaoItensFileBytes != null &&
      relacaoItensFileName != null &&
      resultadosFornecedorFileBytes != null &&
      resultadosFornecedorFileName != null &&
      vigencia != null &&
      pregaoController.text != '' &&
      objetoController.text != '';

  DialogNovaAtaController();

  printPagina() {
    print(pregaoController);
  }

  fecharDialog() {
    vigencia = null;
    relacaoItensFileBytes = null;
    relacaoItensFileName = null;
    resultadosFornecedorFileName = null;
    resultadosFornecedorFileBytes = null;
    pregaoController.text = '';
    objetoController.text = '';
    Get.back();
  }

  selecionarVigencia(BuildContext context) async {
    vigencia = await showDatePicker(
        context: context,
        initialDate: vigencia ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1, 12, 31));
    update();
  }

  selecionarRelacaoItens() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(dialogTitle: 'Selecione o arquivo da relação de itens');
      if (result != null && result.files.single.bytes != null) {
        relacaoItensFileBytes = result.files.single.bytes!;
        relacaoItensFileName = result.files.single.name;
        update();
      }
    } catch (e) {
      UtilService().snackBarErro(
          mensagem: 'Erro ao recuperar arquivo. Tente novamente.');
      print(e);
    }
  }

  selecionarResultado() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          dialogTitle: 'Selecione o arquivo do resultado por fornecedor');
      if (result != null && result.files.single.bytes != null) {
        resultadosFornecedorFileBytes = result.files.single.bytes!;
        resultadosFornecedorFileName = result.files.single.name;
        update();
      }
    } catch (e) {
      UtilService().snackBarErro(
          mensagem: 'Erro ao recuperar arquivo. Tente novamente.');
      print(e);
    }
  }

  excluiRelacaoItens() {
    relacaoItensFileBytes = null;
    relacaoItensFileName = null;
    update();
  }

  excluiResultado() {
    resultadosFornecedorFileBytes = null;
    resultadosFornecedorFileName = null;
    update();
  }

  salvarAta() async {
    if (!formValido) {
      UtilService().snackBarErro(
          objeto: 'Formulário incompleto',
          mensagem: 'Preencha todos os campos para salvar a ata');
      return;
    }
    try {
      print(
          '${pregaoController.text} - ${objetoController.text}, $vigencia, $relacaoItensFileName, $resultadosFornecedorFileName');
      UtilService().showAlertCarregando('Salvando ata...');
      await listaAtasController.repository.salvarAta(
          pregaoController.text,
          objetoController.text,
          vigencia!,
          relacaoItensFileBytes!,
          relacaoItensFileName!,
          resultadosFornecedorFileBytes!,
          resultadosFornecedorFileName!);

      UtilService().fecharAlert();
      fecharDialog();
      UtilService().snackBar(mensagem: 'Sucesso!', objeto: 'Ata salva');
    } catch (e) {
      print(e);
      UtilService().fecharAlert();
      UtilService().snackBarErro();
    }
  }
}
