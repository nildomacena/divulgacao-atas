import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divulgacao_atas/model/campus_model.dart';

class Usuario {
  String nome;
  String email;
  Campus campus;

  Usuario({required this.nome, required this.email, required this.campus});

  factory Usuario.fromFirestore(DocumentSnapshot snapshot, Campus campus) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Usuario(nome: data['nome'], email: data['email'], campus: campus);
  }
}
