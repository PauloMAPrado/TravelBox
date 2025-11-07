import 'package:cloud_firestore/cloud_firestore.dart';

class Cofre {
  // ID privado, final, mas anulável para novos cofres
  final String? id;

  String nome;
  String? descricao;
  int valorPlano;
  int despesasTotal;
  DateTime dataCriacao;
  DateTime? dataViagem;

  Cofre({
    this.id,
    required this.nome,
    required this.valorPlano,
    required this.despesasTotal,
    required this.dataCriacao,
    this.descricao,
    this.dataViagem,
  });

  // --- Métodos de Conversão (JSON) ---

  /// Cria um objeto Cofre a partir de um mapa JSON (vindo do back-end).
  factory Cofre.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Cofre(
      id: doc.id,
      nome: data['nome'] as String,
      descricao: data['descricao'] as String?,
      valorPlano: data['valor_plano'] as int,
      despesasTotal: data['despesas_total'] as int,
      // Converte o Timestamp do Firebase para DateTime
      dataCriacao: (data['data_criacao'] as Timestamp).toDate(),
      dataViagem: data['data_viagem'] != null
          ? (data['data_viagem'] as Timestamp).toDate()
          : null,
    );
  }

  /// Converte o objeto Cofre para um mapa JSON (para enviar ao Firebase).
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'valor_plano': valorPlano,
      'despesas_total': despesasTotal,
      // O Firebase converte DateTime para Timestamp automaticamente
      'data_criacao': dataCriacao,
      'data_viagem': dataViagem,
    };
  }

  /// Cria uma cópia do cofre com valores atualizados.
  Cofre copyWith({
    String? nome,
    String? descricao,
    int? valorPlano,
    int? despesasTotal,
    DateTime? dataCriacao,
    DateTime? dataViagem,
  }) {
    return Cofre(
      id: id, // Preserva o ID original
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      valorPlano: valorPlano ?? this.valorPlano,
      despesasTotal: despesasTotal ?? this.despesasTotal,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataViagem: dataViagem ?? this.dataViagem,
    );
  }
}
