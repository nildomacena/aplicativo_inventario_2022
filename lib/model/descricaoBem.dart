class DescricaoBem {
  final String tombamento;
  final String denominacao;
  final String especificacao;

  DescricaoBem(
      {required this.tombamento,
      required this.denominacao,
      required this.especificacao});

  factory DescricaoBem.fromMap(Map map) {
    return DescricaoBem(
        tombamento: map['num_tombamento'].toString(),
        denominacao: map['denominacao'].toString(),
        especificacao: map['especificacao'].toString());
  }
}
