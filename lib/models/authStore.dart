// lib/stores/auth_store.dart

import 'package:flutter/material.dart';
import 'package:travelbox/services/AuthService.dart';

// Enum para gerenciar o estado da UI de forma clara
enum AuthStatus { initial, loading, success, error }

class AuthStore extends ChangeNotifier {
  final AuthService _authService;
  
  // Estado reativo que a tela observará
  AuthStatus status = AuthStatus.initial;
  String? errorMessage;

  AuthStore(this._authService);

  /// Função para Iniciar a Recuperação de Senha.
  /// Apenas recebe o email e isola a lógica de serviço.
  Future<void> recoverPassword({required String email}) async {
    // 1. Altera o status para loading (para desabilitar o botão na UI)
    status = AuthStatus.loading;
    notifyListeners(); // Notifica a tela

    // 2. Chama o Service (A Cozinha)
    errorMessage = await _authService.resetPassword(email: email);

    // 3. Verifica o resultado e define o novo estado
    if (errorMessage == null) {
      status = AuthStatus.success;
    } else {
      status = AuthStatus.error;
    }

    notifyListeners(); // Notifica a tela com o resultado final
    
    // Opcional: Volta o status para initial após um pequeno tempo 
    // para limpar mensagens de sucesso/erro após a exibição.
    Future.delayed(const Duration(seconds: 3), () {
        status = AuthStatus.initial;
        notifyListeners();
    });
  }

  // Você pode adicionar signIn, signUp e signOut aqui seguindo o mesmo padrão.
}