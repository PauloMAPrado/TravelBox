import 'package:flutter/material.dart';
import 'package:travelbox/models/cofre.dart';
import 'package:travelbox/services/FirestoreService.dart';

// 1. A CLASSE BASE
// ChangeNotifier é a "mágica" do Provider.
// Ele dá o poder de "notificar" os ouvintes.
class CofreProvider extends ChangeNotifier {

  // 2. DEPENDÊNCIA DO SERVICE (A "COZINHA")
  // Ele "conhece" o service, mas a UI não.
  final FirestoreService _firestoreService;
  CofreProvider(this._firestoreService);

  // 3. O "ESTADO" (OS DADOS)
  // Dados privados que a tela vai precisar.
  List<Cofre> _cofres = [];
  bool _isLoading = false;
  String? _errorMessage;

  // 4. OS "GETTERS" (A LEITURA)
  // A forma pública e "somente-leitura" da UI acessar o estado.
  List<Cofre> get cofres => _cofres;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 5. AS "AÇÕES" (A LÓGICA)
  // Funções públicas que a UI pode chamar.

  // Ação de CARREGAR os cofres (ex: quando a tela abre)
  Future<void> buscarCofresDoUsuario(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notifica a UI: "Comecei a carregar!"

    try {
      // Chama o Service (a Cozinha)
      _cofres = await _firestoreService.getCofresDoUsuario(userId);

    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners(); // Notifica a UI: "Terminei! (com sucesso ou erro)"
  }

  // Ação de SALVAR um novo cofre (ex: botão de salvar)
  Future<bool> salvarCofre(String nome, int valorPlano) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notifica a UI: "Estou salvando..."

    try {
      Cofre novoCofre = Cofre(
        nome: nome,
        valorPlano: valorPlano,
        despesasTotal: 0,
        dataCriacao: DateTime.now(),
        joinCode: '',
      );
      
      // Chama o Service (a Cozinha)
      Cofre cofreSalvo = await _firestoreService.criarCofre(novoCofre);
      
      _cofres.add(cofreSalvo); // Atualiza o estado interno
      
      _isLoading = false;
      notifyListeners(); // Notifica a UI: "Terminei de salvar!"
      return true; // Retorna 'true' para a UI (sucesso)

    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners(); // Notifica a UI: "Deu erro!"
      return false; // Retorna 'false' para a UI (falha)
    }
  }
}