
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  // Instância do Cloud Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para salvar dados adicionais do usuário após o cadastro
  Future<void> saveNewUser(
    String uid, 
    String nome, 
    String cpf, 
    String telefone,
  ) async {
    try {
      // Salva os dados na coleção 'users' usando o UID do Firebase Auth como ID do documento
      await _firestore.collection('users').doc(uid).set({
        'nome': nome,
        'cpf': cpf,
        'telefone': telefone,
        'email': 'Seu email aqui, se quiser salvar também', // O email pode ser pego do Auth
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Dados do usuário $uid salvos com sucesso.");
    } catch (e) {
      print("Erro ao salvar dados. $e");
      // Opcionalmente, relance o erro para a UI
      rethrow;
    }
  }
}