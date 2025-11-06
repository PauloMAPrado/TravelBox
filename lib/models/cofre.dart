class Cofre {
  // ID privado, final, mas anulável para novos cofres
  final int? _idCofre;

  String nome;
  String? descricao; 
  int valorPlano;
  int despesasTotal;
  DateTime dataCriacao;
  DateTime? dataViagem; 

  Cofre({
    int? idCofre, 
    required this.nome,
    required this.valorPlano,
    required this.despesasTotal,
    required this.dataCriacao,
    this.descricao,
    this.dataViagem,
  }) : _idCofre = idCofre;

  int? get idCofre => _idCofre;








  // --- Métodos de Conversão (JSON) ---

  /// Cria um objeto Cofre a partir de um mapa JSON (vindo do back-end).
  factory Cofre.fromJson(Map<String, dynamic> json) {
    return Cofre(
      idCofre: json['id_cofre'] as int,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String?,
      valorPlano: json['valor_plano'] as int,
      despesasTotal: json['despesas_total'] as int,
      
      // Datas podem vir como String, precisamos convertê-las
      dataCriacao: DateTime.parse(json['data_criacao'] as String),
      dataViagem: json['data_viagem'] != null
          ? DateTime.parse(json['data_viagem'] as String)
          : null,
    );
  }

  /// Converte o objeto Cofre para um mapa JSON (para enviar ao back-end).
  Map<String, dynamic> toJson() {
    return {
      'id_cofre': _idCofre,
      'nome': nome,
      'descricao': descricao,
      'valor_plano': valorPlano,
      'despesas_total': despesasTotal,
      
      // Converte DateTime de volta para String no formato ISO (ex: "2025-11-05T...")
      // O back-end geralmente prefere este formato.
      'data_criacao': dataCriacao.toIso8601String(),
      'data_viagem': dataViagem?.toIso8601String(), // '?' para lidar com nulo
    };
  }

  // --- Método Utilitário ---

  Cofre copyWith({
    String? nome,
    String? descricao,
    int? valorPlano,
    int? despesasTotal,
    DateTime? dataCriacao,
    DateTime? dataViagem,
  }) {
    return Cofre(
      idCofre: _idCofre,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      valorPlano: valorPlano ?? this.valorPlano,
      despesasTotal: despesasTotal ?? this.despesasTotal,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataViagem: dataViagem ?? this.dataViagem,
    );
  }
}