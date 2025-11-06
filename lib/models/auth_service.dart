// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instância do Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ------------------------------------------
  // 1. REGISTRAR USUÁRIO com Email e Senha
  // ------------------------------------------
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      // Cria um novo usuário no Firebase
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Retorna o objeto User (usuário logado)
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Trata erros específicos do Firebase (ex: email já em uso, senha fraca)
      print("Erro ao registrar: ${e.code}");
      return null;
    } catch (e) {
      print("Erro desconhecido: $e");
      return null;
    }
  }

  // ------------------------------------------
  // 2. FAZER LOGIN com Email e Senha
  // ------------------------------------------
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      // Tenta logar o usuário
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Trata erros (ex: usuário não encontrado, senha incorreta)
      print("Erro ao fazer login: ${e.code}");
      return null;
    } catch (e) {
      print("Erro desconhecido: $e");
      return null;
    }
  }

  // ------------------------------------------
  // 3. OBSERVAR o Estado de Autenticação
  // ------------------------------------------
  // Este stream é ótimo para redirecionar o usuário automaticamente
  Stream<User?> get userChanges => _auth.authStateChanges();
}