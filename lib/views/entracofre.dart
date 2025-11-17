import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';
import 'package:travelbox/views/cofre.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Removido (detalhe de back-end)
// import '../models/cofre_service.dart'; // Removido (será chamado pelo Provider)

// TODO: Importe seu Provider/Gerenciador de Estado aqui
// ex: import 'package:provider/provider.dart';
// ex: import 'package:travelbox/providers/cofre_provider.dart';

class Entracofre extends StatefulWidget {
  const Entracofre({super.key});

  @override
  _EntracofreState createState() => _EntracofreState();
}

class _EntracofreState extends State<Entracofre> {
  // --- Controladores (Estado local da UI) ---
  final TextEditingController _codigoController = TextEditingController();

  // --- _cofreService e _isLoading REMOVIDOS ---
  // A responsabilidade agora é do gerenciador de estado

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

  // --- Lógica da View: Apenas "dispara" o evento ---
  void _handleJoinCofre() {
    // 1. Pega os dados da UI
    final codigoAcesso = _codigoController.text.trim().toUpperCase();

    // 2. Validação local da UI
    if (codigoAcesso.isEmpty) {
      _showSnackBar('Insira um código de acesso.', isError: true);
      return;
    }

    // 3. "Dispara" o evento para o gerenciador de estado
    // A View não é 'async' e não espera resposta.
    
    // TODO: Chame seu gerenciador de estado aqui
    // Exemplo com Provider:
    // context.read<SeuCofreProvider>().joinCofre(
    //   codigoAcesso: codigoAcesso,
    // );
    
    // Exemplo com Riverpod:
    // ref.read(seuCofreProvider.notifier).joinCofre(
    //   codigoAcesso: codigoAcesso,
    // );

    // --- Toda a lógica de 'await', 'setState', 'Navigator' e 'if (sucesso)' foi REMOVIDA ---
  }
  
  @override
  void dispose() {
    _codigoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    // TODO: Obtenha o estado (isLoading) do seu gerenciador
    // Exemplo com Provider:
    // final isLoading = context.watch<SeuCofreProvider>().isLoading;
    
    // Usando um valor fictício por enquanto:
    final bool isLoading = false; // TODO: Substitua pelo seu estado real

    // TODO: Para lidar com Navegação e SnackBars (Sucesso/Erro)
    // Você deve "ouvir" o estado do seu provider.
    /*
    Exemplo de "listener" para efeitos colaterais:
    context.listen<SeuCofreProvider>(
      (previous, next) {
        // Se o status mudou para "sucesso"
        if (next.status == CofreStatus.success && next.justJoinedCofre) { 
          _showSnackBar('Cofre acessado com sucesso!', isError: false);
          
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                // Navega para a tela Cofre refatorada,
                // que buscará os dados do provider.
                builder: (context) => const Cofre(), 
              ),
            );
          }
        } 
        // Se o status mudou para "erro"
        else if (next.status == CofreStatus.error) {
          _showSnackBar(next.errorMessage ?? 'Erro desconhecido', isError: true);
        }
      },
    );
    */

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
                      // 1. O 'onPressed' agora usa o 'isLoading' vindo do provider
                      // 2. A ação agora é uma chamada simples, sem 'async'
                      onPressed: isLoading ? null : _handleJoinCofre,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E90FF),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // O 'child' também usa o 'isLoading' do provider
                      child: isLoading
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