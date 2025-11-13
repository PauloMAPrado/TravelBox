// lib/models/cofre_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class CofreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Função para gerar um código alfanumérico único
  String _generateJoinCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(6, 
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  // ------------------------------------------
  // CRIAR NOVO COFRE
  // Retorna os dados do cofre criado (Map) ou um Map com a chave 'error' (String)
  // ------------------------------------------
  Future<Map<String, dynamic>?> createNewCofre({
    required String nome,
    required String dataInicio, // Data como String (Ex: '2025-12-31')
    required String valorAlvo, // Valor como String
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      return {'error': 'user-not-logged-in'};
    }
    
    // Tenta converter e limpar os dados de entrada
    double parsedValor = double.tryParse(valorAlvo.replaceAll(',', '.')) ?? 0.0;
    DateTime parsedDate;
    try {
        parsedDate = DateTime.parse(dataInicio);
    } catch(e) {
        return {'error': 'invalid-date-format'};
    }


    // 1. Gera o código de acesso
    final String joinCode = _generateJoinCode();
    
    // 2. Cria o objeto do cofre
    final cofreData = {
      'nome': nome,
      'dataInicio': parsedDate, // Salvando como DateTime
      'valorAlvo': parsedValor, // Salvando como double
      'valorAtual': 0.0,
      'codigoAcesso': joinCode,
      'criadorUid': currentUser.uid,
      'membros': [currentUser.uid],
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      // 3. Salva o novo cofre na coleção 'cofres'
      DocumentReference docRef = await _firestore.collection('cofres').add(cofreData);
      
      // 4. Atualiza o documento do usuário logado
      await _firestore.collection('users').doc(currentUser.uid).update({
        'cofresParticipantes': FieldValue.arrayUnion([docRef.id])
      });
      
      // 5. Retorna os dados do Cofre (incluindo o código para a navegação)
      //    A data é convertida para String para simplificar a passagem, ou Timestamp. 
      //    Aqui retornamos o objeto atualizado (Timestamp para a tela)
      
      return {
          ...cofreData, 
          'codigoAcesso': joinCode,
          'dataInicio': Timestamp.fromDate(parsedDate), // Retorna como Timestamp
      };
      
    } catch (e) {
      print("Erro ao criar o cofre: $e");
      return {'error': 'firestore-error'};
    }
  }

  // ------------------------------------------
  // ENTRAR EM COFRE EXISTENTE
  // ------------------------------------------
  Future<Map<String, dynamic>?> joinCofre({
    required String codigoAcesso,
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      return {'error': 'user-not-logged-in'};
    }

    try {
      // 1. Procura o cofre pelo código de acesso
      QuerySnapshot cofreQuery = await _firestore.collection('cofres')
          .where('codigoAcesso', isEqualTo: codigoAcesso)
          .limit(1)
          .get();

      if (cofreQuery.docs.isEmpty) {
        return {'error': 'cofre-not-found'};
      }

      DocumentSnapshot cofreDoc = cofreQuery.docs.first;
      String cofreId = cofreDoc.id;
      Map<String, dynamic> cofreData = cofreDoc.data() as Map<String, dynamic>;
      
      // 2. Verifica se o usuário já é membro
      List<dynamic> membros = cofreData['membros'] ?? [];
      if (membros.contains(currentUser.uid)) {
        // Retorna o cofre mesmo que já seja membro (apenas evita adicionar de novo)
        cofreData['codigoAcesso'] = codigoAcesso; // Adiciona o código de volta
        return cofreData;
      }
      
      // 3. Adiciona o usuário como novo membro
      await _firestore.collection('cofres').doc(cofreId).update({
        'membros': FieldValue.arrayUnion([currentUser.uid])
      });
      
      // 4. (Opcional) Adiciona o cofre ao perfil do usuário
      await _firestore.collection('users').doc(currentUser.uid).update({
        'cofresParticipantes': FieldValue.arrayUnion([cofreId])
      });

      // 5. Retorna os dados do cofre atualizados
      cofreData['codigoAcesso'] = codigoAcesso;
      return cofreData;

    } catch (e) {
      print("Erro ao entrar no cofre: $e");
      return {'error': 'firestore-error'};
    }
  }

  Stream<QuerySnapshot> streamUserCofres() {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      // Retorna um stream vazio se o usuário não estiver logado
      return const Stream.empty();
    }

    // Retorna um stream que monitora os cofres onde o UID do usuário está na lista 'membros'
    return _firestore.collection('cofres')
        .where('membros', arrayContains: currentUser.uid)
        .snapshots();
  }
}