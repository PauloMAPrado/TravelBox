class Usuario {
  int? _id;

  String nome;
  String _email;
  String? telefone;
  String _cpf;

  Usuario({
    int? id,
    required this.nome,
    required String email,
    required String cpf,
    this.telefone,
  }) : _id = id,
       _email = email,
       _cpf = cpf;

  int? get id => _id;
  String get email => _email;
  String get cpf => _cpf;

  void set novoEmail(String novoEmail) {
    _email = novoEmail;
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id_usuario'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      cpf: json['cpf'] as String,
      telefone: json['telefone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': _id,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'telefone': telefone,
    };
  }

  Usuario copyWith({
    String? nome,
    String? email,
    String? telefone,
    String? cpf,
  }) {
    return Usuario(
      id: _id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      cpf: cpf ?? this.cpf,
    );
  }
}
