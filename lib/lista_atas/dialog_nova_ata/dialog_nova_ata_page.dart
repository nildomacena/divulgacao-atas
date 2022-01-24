import 'package:divulgacao_atas/lista_atas/dialog_nova_ata/dialog_nova_ata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogNovaAtaPage extends StatelessWidget {
  final DialogNovaAtaController controller = Get.put(DialogNovaAtaController());
  DialogNovaAtaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget rowDataVigencia = GetBuilder<DialogNovaAtaController>(builder: (_) {
      return Container(
        height: 70,
        margin: const EdgeInsets.only(left: 40, right: 40, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                controller.vigencia == null
                    ? 'SELECIONE A DATA DE VIGÊNCIA'
                    : 'Vigência: ${controller.vigencia!.day}/${controller.vigencia!.month}/${controller.vigencia!.year}',
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: OutlinedButton(
                onPressed: () {
                  controller.selecionarVigencia(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    controller.vigencia == null
                        ? ' SELECIONAR VIGÊNCIA'
                        : 'ALTERAR VIGÊNCIA',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });

    Widget rowPregaoObjeto = Container(
      height: 70,
      margin: const EdgeInsets.only(left: 40, right: 40, top: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              child: TextFormField(
                  controller: controller.pregaoController,
                  /* 
        focusNode: controller.emailFocus,
        validator: controller.validatorEmail, */
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text('NÚMERO DO PREGÃO'),
                    border: OutlineInputBorder(),
                  )),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
                controller: controller.objetoController,
                /* controller: controller.emailController,
        focusNode: controller.emailFocus,
        validator: controller.validatorEmail, */
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('TÍTULO'),
                  border: OutlineInputBorder(),
                )),
          )
        ],
      ),
    );

    Widget relacaoItens = GetBuilder<DialogNovaAtaController>(builder: (_) {
      if (_.relacaoItensFileBytes == null || _.relacaoItensFileName == null) {
        return Container(
          height: 50,
          margin: const EdgeInsets.only(left: 30),
          width: Get.width,
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: OutlinedButton(
              child: const Text(
                'Anexar Relação de Itens',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                _.selecionarRelacaoItens();
              },
            ),
          ),
        );
      } else {
        return Container(
          height: 50,
          margin: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    child: Text(
                      _.relacaoItensFileName!,
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: TextButton.icon(
                  onPressed: () {
                    _.excluiRelacaoItens();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Excluir',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                ),
              )
            ],
          ),
        );
      }
    });

    Widget resultadoPorFornecedor =
        GetBuilder<DialogNovaAtaController>(builder: (_) {
      if (_.resultadosFornecedorFileName == null ||
          _.resultadosFornecedorFileName == null) {
        return Container(
          height: 50,
          margin: const EdgeInsets.only(left: 30),
          width: Get.width,
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: OutlinedButton(
              child: const Text(
                'Anexar Resultados por Fornecedor',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                _.selecionarResultado();
              },
            ),
          ),
        );
      } else {
        return Container(
          height: 50,
          margin: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    child: Text(
                      _.resultadosFornecedorFileName!,
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: TextButton.icon(
                  onPressed: () {
                    _.excluiResultado();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Excluir',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                ),
              )
            ],
          ),
        );
      }
    });

    Widget botaoSalvar = GetBuilder<DialogNovaAtaController>(builder: (_) {
      print('formvalido ${_.formValido}');
      return Container(
        margin: const EdgeInsets.only(top: 30, right: 180, left: 180),
        width: double.infinity,
        height: 50,
        //color: Colors.green[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  overlayColor:
                      MaterialStateProperty.all(Colors.white.withOpacity(.2)),
                ),
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                onPressed: () {
                  _.fecharDialog();
                },
              ),
            ),
            Expanded(child: Container()),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  overlayColor:
                      MaterialStateProperty.all(Colors.white.withOpacity(.2)),
                ),
                child: const Text(
                  'SALVAR ATA',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                onPressed: _.formValido
                    ? () {
                        _.salvarAta();
                      }
                    : null,
              ),
            ),
          ],
        ),
      );
    });

    return Container(
      margin: EdgeInsets.fromLTRB(
        Get.width / 5,
        Get.height / 5,
        Get.width / 5,
        Get.height / 5,
      ),
      child: Card(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                child: const Text(
                  'Cadastrar Nova Ata',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.printPagina();
                },
              ),
            ),
            const Divider(),
            rowPregaoObjeto,
            rowDataVigencia,
            relacaoItens,
            resultadoPorFornecedor,
            Divider(),
            botaoSalvar
          ],
        ),
      ),
    );
  }
}
