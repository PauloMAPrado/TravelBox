import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';
import 'home.dart'; // Importa a tela principal (Dashboard)
import 'package:cloud_firestore/cloud_firestore.dart'; // Necessário para o Timestamp
import '../services/FirestoreService.dart'; // Serviço para lógica do Cofre

class Entracofre extends StatefulWidget {
  const Entracofre({super.key});

  @override
  _EntracofreState createState() => _EntracofreState();
}

class _EntracofreState extends State<Entracofre> {
  // --- Controladores e Serviços ---
  final TextEditingController _codigoController = TextEditingController();
  final CofreService _cofreService = CofreService();
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // --- Lógica de Entrar no Cofre ---
  void _handleJoinCofre() async {
    setState(() {
      _isLoading = true;
    });

    final codigoAcesso = _codigoController.text.trim().toUpperCase();

    if (codigoAcesso.isEmpty) {
      _showSnackBar('Insira um código de acesso.', isError: true);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Chama o serviço para tentar entrar no cofre
    Map<String, dynamic>? cofreData = await _cofreService.joinCofre(
      codigoAcesso: codigoAcesso,
    );

    setState(() {
      _isLoading = false;
    });

    if (cofreData != null && !cofreData.containsKey('error')) {
      // SUCESSO!
      final nome = cofreData['nome'];
      _showSnackBar('Cofre "$nome" acessado com sucesso!', isError: false);

      // Navega para a tela HOME (agora é o Dashboard)
      if (mounted) {
        // Converte o Timestamp (do Firestore) para DateTime
        DateTime dataInicioDateTime = (cofreData['dataInicio'] as Timestamp).toDate();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home( // NAVEGAÇÃO FINAL
              cofreNome: nome,
              valorAlvo: (cofreData['valorAlvo'] as num).toDouble(),
              valorAtual: (cofreData['valorAtual'] as num).toDouble(),
              dataInicio: dataInicioDateTime,
              codigoAcesso: cofreData['codigoAcesso'],
            ),
          ),
        );
      }
    } else {
      // FALHA!
      String message = 'Erro ao entrar no cofre. Tente novamente.';
      if (cofreData != null && cofreData.containsKey('error')) {
        String errorCode = cofreData['error'];
        if (errorCode == 'cofre-not-found') {
          message = 'Código de acesso inválido.';
        } else if (errorCode == 'already-member') {
          message = 'Você já é membro deste cofre.';
        } else if (errorCode == 'user-not-logged-in') {
          message = 'Você precisa estar logado.';
        } else {
          message = 'Erro no servidor. Tente mais tarde.';
        }
      }
      _showSnackBar(message, isError: true);
    }
  }
  
  @override
  void dispose() {
    _codigoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E90FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Header(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40.0),
                    Text(
                      'Insira o código para entrar no cofre',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 17.0,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),

                    const SizedBox(height: 20.0),
                    // CAMPO PARA CÓDIGO
                    TextField(
                      controller: _codigoController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: 'Código do Cofre',
                        labelStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // BOTÃO DE CONFIRMAR
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleJoinCofre, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E90FF),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              'Entrar no Cofre',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Footbarr(),
        ],
      ),
    );
  }
}