import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';
import 'package:travelbox/views/cofre.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importado para usar Timestamp

// Importar o serviço que acabamos de criar (assumindo que o caminho está correto)
import '../models/cofre_service.dart'; 

class Criacofre extends StatefulWidget {
  const Criacofre({super.key});

  @override
  _CriacofreState createState() => _CriacofreState();
}

class _CriacofreState extends State<Criacofre> {
  // --- Controladores e Serviços ---
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataInicioController = TextEditingController();
  final TextEditingController _valorAlvoController = TextEditingController();
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

  // --- Lógica de Criação do Cofre ---
  void _handleCreateCofre() async {
    setState(() { _isLoading = true; });

    final nome = _nomeController.text.trim();
    final dataInicio = _dataInicioController.text.trim();
    final valorAlvo = _valorAlvoController.text.trim();

    // Validação básica
    if (nome.isEmpty || dataInicio.isEmpty || valorAlvo.isEmpty) {
      _showSnackBar('Preencha todos os campos.', isError: true);
      setState(() { _isLoading = false; });
      return;
    }

    // Chama o serviço para criar o cofre e espera o Map de dados
    Map<String, dynamic>? cofreData = await _cofreService.createNewCofre(
      nome: nome,
      dataInicio: dataInicio,
      valorAlvo: valorAlvo,
    );

    setState(() { _isLoading = false; });

    // Verifica se a criação foi um sucesso (não é nulo e não tem chave 'error')
    if (cofreData != null && !cofreData.containsKey('error')) {
      // SUCESSO!
      _showSnackBar('Cofre "$nome" criado com sucesso!', isError: false);
      
      if (mounted) {
        // Converte a data (Timestamp) para DateTime para o construtor da tela
        DateTime dataInicioDateTime = (cofreData['dataInicio'] as Timestamp).toDate();
                            
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Cofre( 
              cofreNome: cofreData['nome'],
              // CORREÇÃO: Usando 'as num' e '.toDouble()' para resolver o erro de tipagem
              valorAlvo: (cofreData['valorAlvo'] as num).toDouble(),
              valorAtual: (cofreData['valorAtual'] as num).toDouble(),
              dataInicio: dataInicioDateTime, // Passa o DateTime
              codigoAcesso: cofreData['codigoAcesso'],
            ),
          ),
        );
      }
    } else {
      // FALHA! 
      String message = 'Erro ao criar cofre. Tente novamente.';
      if (cofreData != null && cofreData.containsKey('error')) {
        String errorCode = cofreData['error'];
        if (errorCode == 'user-not-logged-in') {
          message = 'Você precisa estar logado para criar um cofre.';
        } else if (errorCode == 'firestore-error') {
          message = 'Erro ao salvar dados. Verifique suas regras do Firestore.';
        } else if (errorCode == 'invalid-date-format') {
          message = 'Formato de Data Inválido. Use YYYY-MM-DD.';
        }
      }
      _showSnackBar(message, isError: true);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _dataInicioController.dispose();
    _valorAlvoController.dispose();
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
                child: SingleChildScrollView( 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40.0),
                      Text(
                        'Criar Cofre',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // NOME DO COFRE
                      TextField(
                        controller: _nomeController, 
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Nome do Cofre',
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // DATA DE INÍCIO
                      TextField(
                        controller: _dataInicioController, 
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Data de Início da Viagem (YYYY-MM-DD)', 
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 20.0),

                      // VALOR ALVO
                      TextField(
                        controller: _valorAlvoController, 
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Valor Alvo',
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 25.0),

                      // BOTÃO CONFIRMAR
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleCreateCofre, 
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
                              'Confirmar Cadastro',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, color: Colors.white),
                            ),
                      ),
                      const SizedBox(height: 25.0), 
                    ],
                  ), 
                ),
              ) 
            ), 
          ), 
          const Footbarr(),
        ],
      ),
    );
  }
}