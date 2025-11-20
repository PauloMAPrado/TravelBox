import 'package:flutter/material.dart';
import 'package:travelbox/models/contribuicao.dart';
import 'package:travelbox/models/permissao.dart';
import 'package:travelbox/services/FirestoreService.dart';

class DetalhesCofreProvider extends ChangeNotifier {
  final FirestoreService _firestoreService;

  bool _isLoading = false;
  String? _errorMessege;

  List<Contribuicao> _contribuicoes = [];

  List<Permissao> _membros = [];

  bool get isload => _isLoading;
  String? get errorMensage => _errorMessege;
  List<Contribuicao> get contribuicoes => _contribuicoes;
  List<Permissao> get membros => _membros;

  double get totalArrecadado {
    return _contribuicoes.fold(0.0, (total, atual) => total + atual.valor);
  }

  DetalhesCofreProvider(this._firestoreService);

  Future<void> carregarDadosCofre(String cofreId) async {
    _isLoading = true;
    _errorMessege = null;

    try {
      final results = await Future.wait([
        _firestoreService.getContribuicoesDoCofre(cofreId),
        _firestoreService.getMembrosCofre(cofreId),
      ]);

      _contribuicoes = results[0] as List<Contribuicao>;
    } catch (e) {
      _errorMessege = "Erro ao carregar detalhes: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> adicionarContribuicao({
    required String cofreId,
    required String usuarioId,
    required double valor,
    required DateTime data,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      Contribuicao nova = Contribuicao(
        id: null,
        idCofre: cofreId,
        idUsuario: usuarioId,
        valor: valor,
        data: data,
      );

      await _firestoreService.addContribuicao(nova);

      _contribuicoes.insert(0, nova);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessege = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
