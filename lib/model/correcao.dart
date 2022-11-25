import 'package:cloud_firestore/cloud_firestore.dart';

class Correcao {
  final String id;
  final String bemDescricao;
  final String bemId;
  final String bemPatrimonio;
  final String localidadeId;
  final String localidadeNome;
  final String motivo;
  Correcao(
      {required this.id,
      required this.bemDescricao,
      required this.bemId,
      required this.bemPatrimonio,
      required this.localidadeId,
      required this.localidadeNome,
      required this.motivo});

  @override
  String toString() {
    return 'bemDescricao: $bemDescricao';
  }

  factory Correcao.fromFirestore(DocumentSnapshot snapshot) {
    dynamic data = snapshot.data();
    return Correcao(
      id: snapshot.id,
      bemDescricao: data['bemDescricao'],
      bemId: data['bemId'],
      bemPatrimonio: data['bemPatrimonio'],
      localidadeId: data['localidadeId'],
      localidadeNome: data['localidadeNome'],
      motivo: data['motivo'],
    );
  }
}
