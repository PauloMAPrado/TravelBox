import 'package:travelbox/models/statusConvite.dart';

class Convite {
  final int? _id;

  StatusConvite status;
  DateTime dataEnvio;

  final int idCofre;
  final int idUsuarioConvidador;
  final int idUsuarioConvidado;

  Convite({
    int? id,
    required this.status,
    required this.dataEnvio,
    required this.idCofre,
    required this.idUsuarioConvidador,
    required this.idUsuarioConvidado,
  }) : _id = id;

  int? get idConvite => _id;





  factory Convite.fromJson(Map<String, dynamic> json) {
    return Convite(
      id: json['id_convite'] as int,
      status: StatusConvite.fromString(json['status'] as String),
      dataEnvio: DateTime.parse(json['data_envio'] as String),
      idCofre: json['id_cofre'] as int,
      idUsuarioConvidador: json['id_usuario_convidador'] as int,
      idUsuarioConvidado: json['id_usuario_convidado'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_convite': _id,
      'status': status.name, // Armazena o enum como string (ex: "pendente")
      'data_envio': dataEnvio.toIso8601String(),
      'id_cofre': idCofre,
      'id_usuario_convidador': idUsuarioConvidador,
      'id_usuario_convidado': idUsuarioConvidado,
    };
  }

}
