import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String documentID;
  final String uid;
  final String nome;
  final String email;
  final String papel;
  final String campusId;
  final String campusNome;
  Usuario(
      {required this.nome,
      required this.documentID,
      required this.uid,
      required this.email,
      required this.papel,
      required this.campusId,
      required this.campusNome});

  factory Usuario.fromFirestore(DocumentSnapshot snapshot) {
    dynamic data = snapshot.data();
    return Usuario(
        documentID: snapshot.id,
        nome: data['nome'],
        email: data['email'],
        papel: data['papel'],
        uid: data['uid'],
        campusId: data['campusId'] ?? 'xQvvY7xXGWLIB4Eoj3HI',
        campusNome: data['campus']['campusNome'] ?? 'Benedito Bentes');
  }

  @override
  String toString() {
    return 'Nome: $nome - Campus: $campusNome';
  }
}
