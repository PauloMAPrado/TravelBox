class Contribuicao {
  final int? _idContribuicao;

  double valor;
  DateTime data;

  // Esses dois de baixo é para salvar as chaves estrangeiras como id ;)
  final int idUsuario;
  final int idCofre;

  Contribuicao({
    int? idContribuicao,
    required this.valor,
    required this.data,
    required this.idUsuario,
    required this.idCofre,
  }) : _idContribuicao = idContribuicao;

  int? get idContribuicao => _idContribuicao;









  factory Contribuicao.fromJson(Map<String, dynamic> json) {
    return Contribuicao(
      idContribuicao: json['id_contribuicao'] as int,
      // O banco envia DECIMAL, que o JSON pode tratar como int ou double.
      valor: (json['valor'] as num).toDouble(),
      data: DateTime.parse(json['data'] as String),
      idUsuario: json['id_usuario'] as int,
      idCofre: json['id_cofre'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_contribuicao': _idContribuicao,
      'valor': valor,
      'data': data.toIso8601String(),
      'id_usuario': idUsuario,
      'id_cofre': idCofre,
    };
  }
}
