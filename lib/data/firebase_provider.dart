import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divulgacao_atas/model/campus_model.dart';

class FirebaseProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Campus>> getCampi() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('campi').orderBy('nome').get();
    return querySnapshot.docs.map((s) => Campus.fromFirebase(s)).toList();
  }
}
