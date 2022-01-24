import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  criarUsuario(String email, String nome, String senha, Campus campus) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: senha);
    userCredential.user!.updateDisplayName(nome);
    _firestore.doc('usuarios/${userCredential.user!.uid}').set({
      'email': email,
      'nome': nome,
      'campusNome': campus.nome,
      'campusId': campus.id
    });
  }

  fazerLogin(String email, String senha) {
    return _auth.signInWithEmailAndPassword(email: email, password: senha);
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
