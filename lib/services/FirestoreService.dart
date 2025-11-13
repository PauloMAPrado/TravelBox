import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelbox/models/cofre.dart';
import 'package:travelbox/models/contribuicao.dart';
import 'package:travelbox/models/nivelPermissao.dart';
import 'package:travelbox/models/permissao.dart';
import 'package:travelbox/models/Usuario.dart';
import 'package:travelbox/models/convite.dart'; 

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ----- MÉTODOS DE USUÁRIO -----

  /// Cria o documento de um usuário na coleção 'users'.
  Future<void> criarUsuario(Usuario usuario) async {
    await _db.collection('users').doc(usuario.id).set(usuario.toJson());
  }

  /// Busca um usuário pelo seu ID (uid).
  Future<Usuario?> getUsuario(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return Usuario.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>);
    }
    return null;
  }

  // ----- MÉTODOS DE COFRE -----

  Future<Cofre> criarCofre(Cofre cofre, String creatorUserId) async {
    final docRef = _db.collection('cofres').doc(); 
    
    // Usa o copyWith para adicionar o ID gerado
    Cofre cofreComId = cofre.copyWith(id: docRef.id);
    await docRef.set(cofreComId.toJson());
    
    // !! IMPORTANTE: Adiciona o criador como Admin
    Permissao adminPerm = Permissao(
      id: null, // O Firestore vai gerar o ID
      idUsuario: creatorUserId,
      idCofre: cofreComId.id!,
      nivelPermissao: NivelPermissao.coordenador,
    );
    // Chama o método para criar a permissão
    await criarPermissao(adminPerm);
    
    return cofreComId;
  }

  /// Busca todos os cofres aos quais um usuário tem permissão.
  Future<List<Cofre>> getCofresDoUsuario(String userId) async {
    try {
      final permissoesSnap = await _db
          .collection('permissoes')
          .where('idUsuario', isEqualTo: userId)
          .get();

      final cofreIds = permissoesSnap.docs
          .map((doc) => doc.data()['idCofre'] as String)
          .toSet() 
          .toList();

      if (cofreIds.isEmpty) {
        return [];
      }
      
      // Nota: o whereIn tem limite de 10 itens! Se houver mais, precisa de queries separadas.
      final cofresSnap = await _db
          .collection('cofres')
          .where(FieldPath.documentId, whereIn: cofreIds)
          .get();

      return cofresSnap.docs.map((doc) => Cofre.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
    } catch (e) {
      print("Erro ao buscar cofres: $e");
      return [];
    }
  }

  // ----- MÉTODOS DE CONTRIBUIÇÃO -----

  /// Adiciona uma nova contribuição a um cofre.
  Future<void> addContribuicao(Contribuicao contribuicao) async {
    await _db.collection('contribuicoes').add(contribuicao.toJson());
  }

  /// Busca todas as contribuições de um cofre específico.
  Future<List<Contribuicao>> getContribuicoesDoCofre(String cofreId) async {
    final snapshot = await _db
        .collection('contribuicoes')
        .where('idCofre', isEqualTo: cofreId)
        .orderBy('data', descending: true)
        .get();
        
    return snapshot.docs.map((doc) => Contribuicao.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
  }

  // ----- MÉTODOS DE PERMISSÃO -----

  /// Adiciona uma permissão para um usuário em um cofre.
  Future<void> addPermissao(Permissao permissao) async {
    await _db.collection('permissoes').add(permissao.toJson());
  }

  /// Remove a permissão de um usuário para um cofre específico.
  Future<void> removePermissao(String idUsuario, String idCofre) async {
    final snapshot = await _db
        .collection('permissoes')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('idCofre', isEqualTo: idCofre)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.delete();
    }
  }

  /// Busca todas as permissões de um cofre específico.
  Future<List<Permissao>> getPermissoesDoCofre(String cofreId) async {
    final snapshot = await _db
        .collection('permissoes')
        .where('idCofre', isEqualTo: cofreId)
        .get();
        
    return snapshot.docs.map((doc) => Permissao.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
  }

  // ----- MÉTODOS DE CONVITE -----

  /// Cria um novo convite para um cofre.
  Future<Convite> criarConvite(Convite convite) async {
    final docRef = await _db.collection('convites').add(convite.toJson());
    return convite.copyWith(id: docRef.id);
  }

  /// Busca todos os convites pendentes para um determinado e-mail (usuário convidado).
  Future<List<Convite>> getConvitesParaEmail(String email) async {
    final snapshot = await _db
        .collection('convites')
        .where('emailConvidado', isEqualTo: email.toLowerCase())
        .where('status', isEqualTo: 'pendente')
        .get();
        
    return snapshot.docs.map((doc) => Convite.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
  }

  /// Deleta um convite após ser aceito ou rejeitado.
  Future<void> aceitarOuRejeitarConvite(String conviteId) async {
    await _db.collection('convites').doc(conviteId).delete();
  }
}

/// todos os métodos sservices deixar auqi