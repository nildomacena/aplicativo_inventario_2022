import 'package:aplicativo_inventario_2022/data/auth_provider.dart';
import 'package:aplicativo_inventario_2022/data/firestore_provider.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';

class LocalidadesRepository {
  final FirestoreProvider firestoreProvider;
  final AuthProvider authProvider;
  LocalidadesRepository(
      {required this.firestoreProvider, required this.authProvider});

  Future<void> signOut() {
    return authProvider.signOut();
  }

  Future<List<Localidade>> getLocalidades() {
    return firestoreProvider.getLocalidades();
  }
}
