import 'package:cloud_firestore/cloud_firestore.dart';

class Campus {
  final String id;
  final String nome;

  Campus(this.id, this.nome);

  factory Campus.fromFirebase(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    if (!snapshot.exists || data['nome'] == null) throw 'campus-inexistente';
    return Campus(snapshot.id, data['nome']);
  }
}
