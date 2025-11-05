// Adicione esta rota de login por CPF
router.post('/login', (Request request) async {
  try {
    final body = await request.readAsString();
    final jsonData = _parseJson(body);
    
    final String cpf = jsonData['cpf'];
    final String password = jsonData['password'];
    
    // Buscar usuário pelo CPF
    final user = _users.firstWhere(
      (u) => u.cpf == cpf && u.password == password,
      orElse: () => User(name: '', cpf: '', email: '', phone: '', password: ''),
    );
    
    if (user.email.isEmpty) {
      return Response.unauthorized(
        '{"error": "CPF ou senha incorretos"}',
        headers: {'Content-Type': 'application/json'},
      );
    }
    
    // Login bem-sucedido
    return Response.ok(
      '{"message": "Login realizado com sucesso!", "user": ${user.toJson()}}',
      headers: {'Content-Type': 'application/json'},
    );
    
  } catch (e) {
    return Response.badRequest(
      body: '{"error": "Erro no login: $e"}',
      headers: {'Content-Type': 'application/json'},
    );
  }
});