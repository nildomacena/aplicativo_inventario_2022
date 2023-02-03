import 'package:aplicativo_inventario_2022/data/firestore_provider.dart';
import 'package:aplicativo_inventario_2022/model/bem.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';

class LocalidadeDetailRepository {
  final FirestoreProvider firestoreProvider;
  LocalidadeDetailRepository(this.firestoreProvider);

  Future<List<Bem>> getBens(String localidadeId) {
    return firestoreProvider.getBensPorLocalidadeId(localidadeId);
  }

  Future<Localidade> getLocalidadeById(String id) {
    return firestoreProvider.getLocalidadeById(id);
  }
}
