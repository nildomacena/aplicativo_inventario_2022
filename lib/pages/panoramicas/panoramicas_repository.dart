import 'dart:io';

import 'package:aplicativo_inventario_2022/constants/constants.dart';
import 'package:aplicativo_inventario_2022/data/firestore_provider.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

class PanoramicasRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirestoreProvider firestoreProvider = Get.find();

  salvarPanoramica(
      {required List<File> files, required Localidade localidade}) async {
    List<Future<String>> futures = [];
    List<String> urlsPanoramicas = [];

    futures = files
        .map((f) => _storage
            .ref(
                'localidade/${localidade.id}/panoramicas/${p.basename(f.path)}')
            .putFile(f)
            .then((f) async => await f.ref.getDownloadURL()))
        .toList();
    urlsPanoramicas = await Future.wait(futures);

    await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}')
        .update({
      'panoramicas': [...localidade.panoramicas, ...urlsPanoramicas],
      'panoramica': urlsPanoramicas.first
    });
  }

  Future<Localidade> updateLocalidade(Localidade localidade) {
    return _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}')
        .get()
        .then((s) => Localidade.fromFirestore(s, Constants.idCampusBB));
  }

  Future<Localidade> excluirPanoramica(
      Localidade localidade, String panoramica) async {
    localidade = await firestoreProvider.getLocalidadeById(localidade.id);
    List<dynamic> panoramicas = localidade.panoramicas;
    panoramicas.remove(panoramica);
    await _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}')
        .update({'panoramicas': panoramicas, 'panoramica': panoramicas.first});
    try {
      Reference reference = _storage.refFromURL(panoramica);
      await reference.delete();
    } catch (e) {
      print('Nao foi possivel excluir a imagem no storage: $e');
    }
    return firestoreProvider.getLocalidadeById(localidade.id);
  }
}
