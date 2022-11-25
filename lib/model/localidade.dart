import 'package:aplicativo_inventario_2022/model/bem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status { nao_iniciado, em_andamento, finalizado }

class Localidade {
  final String nome;
  final String id;
  final String campusId;
  Status? status;
  String
      panoramica; //Alterar para array quando o mesmo estiver sendo salvo no banco de dados
  List<Bem> bens;
  String? imagemRelatorio;
  String? observacoes;
  Localidade(
      {required this.nome,
      required this.id,
      required this.campusId,
      required this.panoramica,
      required this.bens,
      required this.status,
      this.imagemRelatorio,
      this.observacoes}) {
    if (status == null && bens.isEmpty) {
      status = Status.nao_iniciado;
    } else {
      status ??= Status.em_andamento;
    }
  }

  Future<void> addBensFromFirestore(QuerySnapshot snapshotBens) async {
    bens = snapshotBens.docs.map((e) => Bem.fromFirestore(e)).toList();
    return;
  }

  factory Localidade.fromFirestore(DocumentSnapshot snapshot, String campusId,
      {QuerySnapshot? snapshotBens}) {
    dynamic data = snapshot.data();
    Status? status;
    List<Bem> bens = [];
    if (snapshotBens != null && snapshotBens.docs.isNotEmpty) {
      bens = snapshotBens.docs.map((e) => Bem.fromFirestore(e)).toList();
    }

    if (data['status'] == null) {
      status = bens.isNotEmpty ? Status.em_andamento : Status.nao_iniciado;
    }
    return Localidade(
        nome: data['nome'],
        panoramica: data['panoramica'],
        imagemRelatorio: data['imagemRelatorio'] ?? '',
        observacoes: data['observacoes'] ?? '',
        status: status ??
            (data['status'] == 2
                ? Status.finalizado
                : data['status'] == 1
                    ? Status.em_andamento
                    : Status.nao_iniciado),
        id: snapshot.id,
        campusId: campusId,
        bens: bens);
  }

  bool get possuiImagemRelatorio {
    return imagemRelatorio != null &&
        imagemRelatorio != null &&
        imagemRelatorio!.isNotEmpty;
  }

  factory Localidade.fromFirestoreComBensTeste(
      DocumentSnapshot snapshot, String campusId,
      {QuerySnapshot? snapshotBens}) {
    dynamic data = snapshot.data();
    Status? status;
    List<Bem> bens = [];
    if (snapshotBens != null && snapshotBens.docs.isNotEmpty) {
      bens = snapshotBens.docs.map((e) => Bem.fromFirestore(e)).toList();
    }

    if (data['status'] == null) {
      status = bens.isNotEmpty ? Status.em_andamento : Status.nao_iniciado;
    }
    return Localidade(
        nome: data['nome'],
        panoramica: data['panoramica'],
        status: status ??
            (data['status'] == 2
                ? Status.finalizado
                : data['status'] == 1
                    ? Status.em_andamento
                    : Status.nao_iniciado),
        id: snapshot.id,
        campusId: campusId,
        bens: bens);
  }

  String get statusAsString {
    if (status == Status.nao_iniciado) return 'Não iniciado';
    if (status == Status.em_andamento) return 'Em andamento';
    if (status == Status.finalizado) {
      return 'Finalizado';
    } else {
      return 'Em andamento';
    }
  }

  @override
  String toString() {
    return 'Id: $id - Nome: $nome - Bens: ${bens.length}';
  }
}
