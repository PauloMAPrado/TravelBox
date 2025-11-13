import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelbox/models/Usuario.dart';
import 'package:travelbox/services/FirestoreService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // O AuthService "conversa" com o FirestoreService
  // para salvar os dados do usuário após o cadastro.
  final FirestoreService _firestoreService;
  AuthService(this._firestoreService);

  /// Retorna o usuário logado atualmente (ou nulo)
  User? get currentUser => _auth.currentUser;

  /// Stream para "ouvir" mudanças de autenticação (login, logout)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Tenta fazer login com email e senha.
  /// Retorna uma mensagem de erro se falhar, ou null se tiver sucesso.
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return e.message; // Retorna a mensagem de erro (ex: "wrong-password")
    }
  }

  /// Tenta criar um novo usuário (cadastro).
  Future<String?> signUp({
    required String email,
    required String password,
    required String nome,
    required String cpf,
    String? telefone,
  }) async {
    try {
      // --- Passo 1: Criar o usuário no Firebase Authentication ---
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw Exception("Usuário não criado.");
      }
      String uid = userCredential.user!.uid;
      // --- Passo 2: Salvar os dados *extras* no Cloud Firestore ---
      // 1. Cria o objeto Model com os dados
      Usuario novoUsuario = Usuario(
        id: uid, // O ID do Auth é o ID do Firestore
        nome: nome,
        email: email,
        cpf: cpf,
        telefone: telefone,
      );
      // 2. Chama o FirestoreService para salvar
      await _firestoreService.criarUsuario(novoUsuario);
      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return e.message; // Retorna erro do Auth (ex: "email-already-in-use")
    } catch (e) {
      return e.toString(); // Retorna erro do Firestore
    }
  }

  /// Faz o logout do usuário.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
