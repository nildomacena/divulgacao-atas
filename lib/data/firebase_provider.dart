import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divulgacao_atas/model/ata_model.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:divulgacao_atas/model/usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Rxn<Usuario> usuario$ = Rxn<Usuario>();

  FirebaseProvider() {
    usuario$.bindStream(_auth.authStateChanges().asyncMap((User? user) async {
      if (user != null) {
        return await getUsuarioByUid(user.uid);
      }
      return null;
    }));
  }

  Usuario? get usuario => usuario$.value;

  Future<dynamic> salvarAnuncio(
      String pregao,
      String objeto,
      DateTime vigencia,
      Uint8List relacaoItens,
      String relacaoItensFileName,
      Uint8List resultadosFornecedor,
      String resultadosFornecedorFileName) async {
    String? linkRelacaoItens;
    String? linkResultados;

    if (usuario == null) {
      throw 'usuario-nulo';
    }

    DocumentReference ref = await _firestore.collection('atas').add({
      'pregao': pregao,
      'objeto': objeto,
      'vigencia': vigencia,
      'campusId': usuario!.campus.id,
      'campusNome': usuario!.campus.nome,
      'campus': usuario!.campus.toJson
    });

    await _storage
        .ref('atas/${ref.id}/$relacaoItensFileName')
        .putData(relacaoItens)
        .then((task) async {
      linkRelacaoItens = await task.ref.getDownloadURL();
    });
    await _storage
        .ref('atas/${ref.id}/$resultadosFornecedorFileName')
        .putData(resultadosFornecedor)
        .then((task) async {
      linkResultados = await task.ref.getDownloadURL();
    });

    return ref.update({
      'relacaoItens': linkRelacaoItens,
      'resultadosFornecedor': linkResultados,
    });
  }

  Future<Usuario> getUsuarioByUid(String uid) async {
    DocumentSnapshot snapshot = await _firestore.doc('usuarios/$uid').get();
    Campus campus = await getCampusById(
        (snapshot.data() as Map<String, dynamic>)['campusId']);
    return Usuario.fromFirestore(snapshot, campus);
  }

  Future<Campus> getCampusById(String id) async {
    return Campus.fromFirestore((await _firestore.doc('campi/$id').get()));
  }

  Future<List<Campus>> getCampi() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('campi').orderBy('nome').get();
    return querySnapshot.docs.map((s) => Campus.fromFirestore(s)).toList();
  }

  Future<List<Ata>> getAtas([Campus? campus]) async {
    QuerySnapshot querySnapshot = campus == null
        ? await _firestore.collection('atas').get()
        : await _firestore
            .collection('atas')
            .where('campusId', isEqualTo: campus.id)
            .get();
    return querySnapshot.docs.map((s) => Ata.fromFirestore(s)).toList();
  }

  Stream<List<Ata>> streamAtas(Campus? campus) {
    return campus == null
        ? _firestore.collection('atas').snapshots().map(
            (QuerySnapshot querySnapshot) =>
                querySnapshot.docs.map((s) => Ata.fromFirestore(s)).toList())
        : _firestore
            .collection('atas')
            .where('campusId', isEqualTo: campus.id)
            .snapshots()
            .map((QuerySnapshot querySnapshot) =>
                querySnapshot.docs.map((s) => Ata.fromFirestore(s)).toList());
  }
}
