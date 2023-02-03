import 'dart:io';

import 'package:aplicativo_inventario_2022/constants/constants.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FinalizarLocalidadeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  finalizarLocalidade(
      {required Localidade localidade,
      required File file,
      required String observacoes}) async {
    String downloadUrl = await _storage
        .ref('bens/${p.basename(file.path)}')
        .putFile(file)
        .then((f) async => await f.ref.getDownloadURL());

    return _firestore
        .doc('${Constants.pathBB}/localidades/${localidade.id}')
        .update({
      'status': Status.finalizado.index,
      'imagemRelatorio': downloadUrl
    });
  }
}
