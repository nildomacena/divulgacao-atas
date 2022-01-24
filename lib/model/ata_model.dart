import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divulgacao_atas/model/campus_model.dart';

class Ata {
  String id;
  String pregao;
  String objeto;
  DateTime vigencia;
  String relacaoItens;
  String resultadosFornecedor;
  Campus campus;

  Ata(
      {required this.id,
      required this.pregao,
      required this.vigencia,
      required this.relacaoItens,
      required this.objeto,
      required this.resultadosFornecedor,
      required this.campus});

  String get vigenciaFormatada =>
      '${vigencia.day}/${vigencia.month}/${vigencia.year}';

  factory Ata.fromFirestore(DocumentSnapshot snapshot, [Campus? campus]) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Ata(
      id: snapshot.id,
      pregao: data['pregao'],
      objeto: data['objeto'],
      vigencia: data['vigencia'].toDate(),
      relacaoItens: data['relacaoItens'] ?? '',
      resultadosFornecedor: data['resultadosFornecedor'] ?? '',
      campus: campus ??
          Campus(
            data['campusId'],
            data['campusNome'],
          ),
    );
  }
}
