import 'package:auto_size_text/auto_size_text.dart';
import 'package:divulgacao_atas/model/ata_model.dart';
import 'package:divulgacao_atas/services/util_service.dart';
import 'package:flutter/material.dart';

class CardAta extends StatelessWidget {
  Ata ata;

  CardAta(this.ata, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Card(
        color: Colors.green[100],
        elevation: 10,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: AutoSizeText(
                  'Ata ${ata.pregao} - ${ata.objeto} ',
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                )),
            const Divider(),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: AutoSizeText(
                  'Vigência: ${ata.vigenciaFormatada}',
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w300),
                )),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30, left: 20),
              child: const Text(
                'Downloads',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 15, left: 10),
              child: TextButton(
                onPressed: () {
                  utilService.downloadLink(ata.relacaoItens);
                },
                child: const Text(
                  'Relação de Itens',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: TextButton(
                onPressed: () {
                  utilService.downloadLink(ata.resultadosFornecedor);
                },
                child: const Text(
                  'Resultados por fornecedor',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
