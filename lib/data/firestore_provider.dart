import 'package:aplicativo_inventario_2022/constants/constants.dart';
import 'package:aplicativo_inventario_2022/model/bem.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkIfUserExists(
      {required String cpf, required String siape}) async {
    QuerySnapshot snapshot = await _firestore
        .collection('usuarios')
        .where('cpf', isEqualTo: cpf)
        .where('siape', isEqualTo: siape)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> checkPreRegistration(
      {required String cpf, required String siape}) async {
    print('${Constants.pathBB}/preCadastros');
    QuerySnapshot snapshot = await _firestore
        .collection('${Constants.pathBB}/preCadastros')
        .where('cpf', isEqualTo: cpf)
        .where('siape', isEqualTo: siape)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<dynamic> createUser(
      {required String uid,
      required String cpf,
      required String siape,
      required String nome}) async {
    QuerySnapshot snapshotPreCadastro = await _firestore
        .collection('${Constants.pathBB}/preCadastros')
        .where('cpf', isEqualTo: cpf)
        .where('siape', isEqualTo: siape)
        .get();
    if (!snapshotPreCadastro.docs.first.exists) {
      throw 'pre-registration-not-exists';
    }
    Map<String, dynamic> preCadastro =
        snapshotPreCadastro.docs.first.data() as Map<String, dynamic>;

    return _firestore.doc('usuarios/$uid').set({
      'campus': {'id': Constants.idCampusBB, 'nome': 'Benedito Bentes'},
      'campusId': Constants.idCampusBB,
      'campusNome': 'Benedito Bentes',
      'confirmado': true,
      'cpf': cpf,
      'dataPreCadastro': preCadastro['dataPreCadastro'],
      'dataSignup': FieldValue.serverTimestamp(),
      'idPreCadastro': snapshotPreCadastro.docs.first.id,
      'nome': nome,
      'papel': 'padrao',
      'siape': siape,
      'uid': uid,
    });
  }

  Future<Usuario> getUsuarioByUid(String uid) async {
    DocumentSnapshot snapshot = await _firestore.doc('usuarios/$uid').get();
    return Usuario.fromFirestore(snapshot);
  }

  Future<List<Localidade>> getLocalidades() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        (await _firestore.collection('${Constants.pathBB}/localidades').get());
    return querySnapshot.docs
        .map((s) => Localidade.fromFirestore(s, Constants.idCampusBB))
        .toList();
  }

  Future<List<Bem>> getBensPorLocalidadeId(String localidadeId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = (await _firestore
        .collection('${Constants.pathBB}/localidades/$localidadeId/bens')
        .get());
    if (querySnapshot.docs.isEmpty) return [];
    return querySnapshot.docs.map((s) => Bem.fromFirestore(s)).toList();
  }
}
