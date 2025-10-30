class Usuario {
  int? id;
  String _nome;
  String _email;
  String _telefone;
  String _senha;
  String _cpf;

  Usuario(this._nome, this._email, this._telefone, this._cpf, this._senha);

  String get nome => _nome;
  String get email => _email;
  String get telefone => _telefone;
  String get cpf => _cpf;
  String get senha => _senha;

  set nome(String novoNome) {
    _nome = novoNome;
  }
}

void main() {
  Usuario user1 = Usuario(
    "Luis",
    "luis@gmail",
    "123",
    "123456789",
    "123456789",
  );

  print(user1.nome);
  print(user1.email);
  print(user1.telefone);
  print(user1.cpf);
  print(user1.senha);

  user1.nome = "Italo";

}
