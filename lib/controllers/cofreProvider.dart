import 'package:travelbox/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:travelbox/models/cofre.dart';
import 'package:travelbox/models/permissao.dart';
import 'package:travelbox/models/nivelPermissao.dart';

class CofreProvider extends ChangeNotifier {

  // 2. DEPENDÊNCIA DO SERVICE (A "COZINHA")
  // Ele "conhece" o service, mas a UI não.
  final FirestoreService _firestoreService;
  CofreProvider(this._firestoreService);

  List<Cofre> _cofres = [];
  List<Cofre> get cofres => _cofres;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  // ...

  // ATUALIZAÇÃO: salvarCofre agora precisa saber QUEM está criando
  Future<bool> salvarCofre(String nome, int valorPlano, String creatorUserId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Usamos nosso novo factory 'Cofre.novo'
      Cofre novoCofre = Cofre.novo(
        nome: nome,
        valorPlano: valorPlano,
      );
      
      // Passa o cofre e o ID do criador para o service
      Cofre cofreSalvo = await _firestoreService.criarCofre(novoCofre, creatorUserId);
      
      _cofres.add(cofreSalvo); // Adiciona o novo cofre à lista local
      
      _isLoading = false;
      notifyListeners();
      return true;

    } catch (e) {
      _errorMessage = "Erro ao salvar cofre: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false; // Return false on error
    }
  }

  /// NOVA AÇÃO: Entrar em um cofre existente com um código
  /// Retorna (null) em sucesso, ou (String de erro) em falha.
  Future<String?> entrarComCodigo(String code, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. Acha o cofre pelo código
      // Normaliza o código para maiúsculas para facilitar a digitação
      final cofre = await _firestoreService.findCofreByCode(code.toUpperCase().trim());

      if (cofre == null) {
        _isLoading = false;
        notifyListeners();
        return "Código inválido. Verifique e tente novamente.";
      }
      
      // 2. Cria uma permissão de "leitor" (ou 'membro', 'editor', etc)
      Permissao novaPermissao = Permissao(
        id: null,
        idUsuario: userId,
        idCofre: cofre.id!,
        nivelPermissao: NivelPermissao.contribuinte, // Nível padrão para quem entra
      );

      // 3. Salva a permissão
      await _firestoreService.criarPermissao(novaPermissao);

      // 4. (Opcional) Adiciona o cofre à lista local
      if (!_cofres.any((c) => c.id == cofre.id)) {
        _cofres.add(cofre);
      }
      
      _isLoading = false;
      notifyListeners();
      return null; // Sucesso!

    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return "Erro ao tentar entrar no cofre: ${e.toString()}";
    }
  }
}