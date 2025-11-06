import 'package:cloud_firestore/cloud_firestore.dart';

class Contribuicao {
  final String? id;

  double valor;
  DateTime data;

  // Esses dois de baixo é para salvar as chaves estrangeiras como id ;)
  final String idUsuario;
  final String idCofre;

  Contribuicao({
    this.id,
    required this.valor,
    required this.data,
    required this.idUsuario,
    required this.idCofre,
  })





  factory Contribuicao.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Contribuicao(
      id: doc.id,
      valor: (data['valor'] as num).toDouble(), 
      // O Firestore armazena datas como 'Timestamp'. Convertemos para DateTime.
      data: (data['data'] as Timestamp).toDate(), 
      idUsuario: data['id_usuario'] as String,
      idCofre: data['id_cofre'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'valor': valor,
      'data': data, // O Firestore entende objetos DateTime e converte para Timestamp
      'id_usuario': idUsuario,
      'id_cofre': idCofre,
    };
  }
}
