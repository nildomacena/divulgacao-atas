import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  criarUsuario(String email, String nome, String senha, Campus campus) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: senha);
    userCredential.user!.updateDisplayName(nome);
    _firestore.collection('usuarios').add({
      'email': email,
      'nome': nome,
      'campusNome': campus.nome,
      'campusId': campus.id
    });
  }
}
