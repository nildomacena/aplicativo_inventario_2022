import 'dart:io';

import 'package:aplicativo_inventario_2022/constants/constants.dart';
import 'package:aplicativo_inventario_2022/data/auth_provider.dart';
import 'package:aplicativo_inventario_2022/data/firestore_provider.dart';
import 'package:aplicativo_inventario_2022/model/bem.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

class AdicionarBemRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  FirestoreProvider provider = Get.find();
  AuthProvider authProvider = Get.find();

  Future<Bem> salvarBem(
      {required File file,
      required Localidade localidade,
      required String patrimonio,
      required String descricao,
      required String numeroSerie,
      required String estado,
      required String observacoes,
      required bool particular,
      required bool semEtiqueta,
      required bool desfazimento}) async {
    print('salvar bem');
    Usuario? usuario = await provider.getUsuario();

    if (usuario == null) throw 'Usuário não encontrado';

    Map<String, dynamic> data = {
      'aCorrigir': false,
      'bemParticular': particular,
      'campusId': Constants.idCampusBB,
      'deletado': false,
      'descricao': descricao,
      'estadoBem': estado,
      'indicaDesfazimento': desfazimento,
      'localidadeId': localidade.id,
      'nomeUsuario': usuario.nome,
      'numeroSerie': numeroSerie,
      'observacoes': observacoes,
      'patrimonio': patrimonio,
      'semEtiqueta': semEtiqueta,
      'timestamp': FieldValue.serverTimestamp(),
      'uidUsuario': usuario.uid
    };

    if (!particular && !semEtiqueta) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('${Constants.pathBB}/bens')
          .where('patrimonio', isEqualTo: patrimonio)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot localidadeSnapshot = await _firestore
            .doc('${Constants.pathBB}/localidades/${localidade.id}')
            .get();
        String localidadeNome = (localidadeSnapshot.data() as Map)['nome'];
        throw 'O bem com patrimônio $patrimonio já está cadastrado na localidade $localidadeNome';
      }
    }
    DocumentReference ref =
        await _firestore.collection('${Constants.pathBB}/bens').add(data);

    String downloadUrl = await _storage
        .ref('bens/${p.basename(file.path)}')
        .putFile(file)
        .then((f) async => await f.ref.getDownloadURL());

    data['imagem'] = downloadUrl;

    await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}/bens/${ref.id}')
        .set(data);

    Bem bem = Bem.fromFirestore(await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}/bens/${ref.id}')
        .get());

    await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}')
        .update({'status': Status.em_andamento.index});

    return bem;
  }

  Future<Bem> updateBem({
    required Bem bem,
    required Localidade localidade,
    required String patrimonio,
    required String descricao,
    required String numeroSerie,
    required String estado,
    required String observacoes,
    required bool particular,
    required bool semEtiqueta,
    required bool desfazimento,
    File? file,
  }) async {
    String? downloadUrl;
    Usuario? usuario = await provider.getUsuario();

    if (usuario == null) throw 'Usuário não encontrado';

    if (file != null) {
      _storage.refFromURL(bem.imagem).delete();
      downloadUrl = await _storage
          .ref('inventario2022/bens/${p.basename(file.path)}')
          .putFile(file)
          .then((f) async => await f.ref.getDownloadURL());
    }

    Map<String, dynamic> data = {
      'aCorrigir': false,
      'bemParticular': particular,
      'campusId': Constants.idCampusBB,
      'deletado': false,
      'descricao': descricao,
      'estadoBem': estado,
      'indicaDesfazimento': desfazimento,
      'localidadeId': localidade.id,
      'nomeUsuario': usuario.nome,
      'numeroSerie': numeroSerie,
      'observacoes': observacoes,
      'patrimonio': patrimonio,
      'semEtiqueta': semEtiqueta,
      'timestamp': FieldValue.serverTimestamp(),
      'uidUsuario': usuario.uid
    };
    if (downloadUrl != null) {
      data['imagem'] = downloadUrl;
    }

    await _firestore.doc('${Constants.pathBB}/bens/${bem.id}').update(data);
    await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}/bens/${bem.id}')
        .update(data);

    Bem novoBem = Bem.fromFirestore(await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}/bens/${bem.id}')
        .get());

    return novoBem;
  }

  excluirBem({required Localidade localidade, required Bem bem}) async {
    if (bem.imagem.isNotEmpty) {
      await _storage.refFromURL(bem.imagem).delete();
    }
    await _firestore.doc('${Constants.pathBB}/bens/${bem.id}').delete();
    await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}/bens/${bem.id}')
        .delete();
    return;
  }
}
