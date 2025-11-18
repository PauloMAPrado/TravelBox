import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';

class Criacofre extends StatefulWidget {
  const Criacofre({super.key});

  @override
  _CriacofreState createState() => _CriacofreState();
}

class _CriacofreState extends State<Criacofre> {
  // --- Controladores (Estado local da UI) ---
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataInicioController = TextEditingController();
  final TextEditingController _valorAlvoController = TextEditingController();

  // --- O CofreService e o _isLoading foram REMOVIDOS ---
  // Eles agora vivem no seu gerenciador de estado (Provider, Bloc, etc.)

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
  void _handleCreateCofre() {
    // 1. Pega os dados da UI
    final nome = _nomeController.text.trim();
    final dataInicio = _dataInicioController.text.trim();
    final valorAlvo = _valorAlvoController.text.trim();

    // 2. Validação local da UI
    if (nome.isEmpty || dataInicio.isEmpty || valorAlvo.isEmpty) {
      _showSnackBar('Preencha todos os campos.', isError: true);
      return;
    }

    // 3. "Dispara" o evento para o gerenciador de estado
    // A View não é mais 'async' e não espera uma resposta.
    // Ela apenas envia os dados e confia que o gerenciador fará o resto.
    
    // TODO: Chame seu gerenciador de estado aqui
    // Exemplo com Provider:
    // context.read<SeuCofreProvider>().createNewCofre(
    //   nome: nome,
    //   dataInicio: dataInicio,
    //   valorAlvo: valorAlvo,
    // );
    
    // Exemplo com Riverpod:
    // ref.read(seuCofreProvider.notifier).createNewCofre(
    //   nome: nome,
    //   dataInicio: dataInicio,
    //   valorAlvo: valorAlvo,
    // );

    // --- Toda a lógica de 'await', 'setState', 'Navigator' e 'if (sucesso)' foi REMOVIDA ---
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
    
    // TODO: Obtenha o estado (isLoading) do seu gerenciador
    // Exemplo com Provider:
    // final isLoading = context.watch<SeuCofreProvider>().isLoading;
    
    // Observação: por enquanto não usamos um flag local; o gerenciador de estado
    // deve controlar habilitação/feedback visual (loading) da ação.

    // TODO: Para lidar com Navegação e SnackBars (Sucesso/Erro)
    // Você deve "ouvir" o estado do seu provider.
    // O local exato depende do gerenciador (ex: BlocListener, ou 'listen' do Provider)
    /*
    Exemplo de "listener" para efeitos colaterais:
    context.listen<SeuCofreProvider>(
      (previous, next) {
        // Se o status mudou para "sucesso"
        if (next.status == CofreStatus.success) { 
          _showSnackBar('Cofre criado com sucesso!', isError: false);
          
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
                      // O botão redireciona para a tela inicial do cofre apos sua criação
                      ElevatedButton(
                        onPressed: _handleCreateCofre, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E90FF),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Confirmar',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0), 
                    ],
                  ), 
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