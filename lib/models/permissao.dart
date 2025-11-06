import 'package:travelbox/models/nivelPermissao.dart';

class Permissao {
  final int? _id;

  NivelPermissao nivelPermissao;

  final int idUsuario;
  final int idCofre;

  Permissao({
    int? id,
    required this.nivelPermissao,
    required this.idUsuario,
    required this.idCofre,
  }) : _id = id;

  int? get idPermissao => _id;






  factory Permissao.fromJson(Map<String, dynamic> json) {
    return Permissao(
      id: json['id_permissao'] as int,
      // Usa o helper 'fromString' do nosso enum
      nivelPermissao: NivelPermissao.fromString(json['nivel_permissao'] as String),
      idUsuario: json['id_usuario'] as int,
      idCofre: json['id_cofre'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_permissao': _id,
      // Armazena o enum como uma string (ex: "admin")
      'nivel_permissao': nivelPermissao.name, 
      'id_usuario': idUsuario,
      'id_cofre': idCofre,
    };
  }

}
