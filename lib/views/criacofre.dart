import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; 


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
  
  // --- Formatadores e Variáveis de Estado ---
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy'); // Formatador para exibir a data
  
  // Inicialização do formatador de máscara para R$
  final _currencyMask = MaskTextInputFormatter(
    mask: '#.###.###,00', // Máscara que aceita até 9.999.999,99
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  
  // Placeholder de carregamento (substitua pelo seu Provider)
  // O const é removido aqui, pois o valor deve ser dinâmico.
  // bool _isLoading = false;

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

  // --- Seletor de Data ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      helpText: 'Selecione a Data de Início',
    );
    if (picked != null) {
      // Salva a data no formato YYYY-MM-DD no controlador (para o backend)
      _dataInicioController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // --- Lógica da View: Apenas "dispara" o evento ---
  void _handleCreateCofre() {
    // 1. Pega os dados da UI
    final nome = _nomeController.text.trim();
    final dataInicio = _dataInicioController.text.trim();
    final valorAlvoFormatado = _valorAlvoController.text.trim(); 

    // 2. Validação básica de preenchimento
    if (nome.isEmpty || dataInicio.isEmpty || valorAlvoFormatado.isEmpty) {
      _showSnackBar('Preencha todos os campos.', isError: true);
      return;
    }

    // 3. Validação e Limpeza do Valor Alvo (para double)
    final cleanValorAlvo = valorAlvoFormatado
        .replaceAll('R\$', '')
        .replaceAll('.', '') // Remove ponto de milhar
        .replaceAll(',', '.') // Converte vírgula para ponto decimal
        .trim(); 

    final double? parsedValorAlvo = double.tryParse(cleanValorAlvo);

    if (parsedValorAlvo == null || parsedValorAlvo <= 0) {
      _showSnackBar('O Valor Alvo deve ser um número maior que R\$ 0,00.', isError: true);
      return;
    }

    // 4. "Dispara" o evento para o gerenciador de estado (Exemplo)
    
    // TODO: Chame seu gerenciador de estado (Provider) aqui
    /*
    context.read<SeuCofreProvider>().createNewCofre(
      nome: nome,
      dataInicio: dataInicio, 
      valorAlvo: parsedValorAlvo, // Passa o double validado
    );
    */

    // Exemplo de sucesso (remova isto quando o provider for conectado)
    _showSnackBar('Validação OK! Cofre: $nome, Valor: R\$ ${parsedValorAlvo.toStringAsFixed(2)}', isError: false);
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
    
    // Placeholder de carregamento (substitua pelo seu Provider)

    return Scaffold(
      backgroundColor: const Color(0xFF1E90FF), // Mantido const aqui é seguro
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(), // Removido 'const' para evitar o warning
          Expanded(
            child: Container(
              decoration: const BoxDecoration( // Mantido const aqui é seguro
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView( // Para evitar overflow do teclado
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40.0),
                      Text(
                        'Crie sua meta de viagem',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      
                      // NOME DO COFRE
                      TextField(
                        controller: _nomeController, 
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Nome do Cofre (Ex: Tailândia 2026)',
                          prefixIcon: const Icon(Icons.flight_takeoff, color: Color(0xFF1E90FF)),
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // DATA DE INÍCIO (Seletor)
                      GestureDetector(
                        // LÓGICA CORRIGIDA: Usa a função anônima para chamar _selectDate(context)
                        onTap: () => _selectDate(context), 
                        child: AbsorbPointer( // Impede a edição direta do campo
                          child: TextField(
                            controller: _dataInicioController, 
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: _dataInicioController.text.isEmpty
                                  ? 'Data de Início da Viagem'
                                  : _dateFormat.format(DateTime.parse(_dataInicioController.text)), 
                              prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF1E90FF)),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              labelStyle: GoogleFonts.poppins(),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // VALOR ALVO
                      TextField(
                        controller: _valorAlvoController, 
                        keyboardType: const TextInputType.numberWithOptions(decimal: true), 
                        decoration: InputDecoration(
                          labelText: 'Valor Alvo',
                          prefixIcon: const Icon(Icons.attach_money, color: Color(0xFF1E90FF)),
                          prefixText: 'R\$ ', 
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(),
                      
                        // Aplicação da Máscara de Moeda
                        inputFormatters: [_currencyMask],    
                      ),
                      const SizedBox(height: 25.0),

                      // BOTÃO CONFIRMAR
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
          Footbarr(), // Removido 'const' para evitar o warning
        ],
      ),
    );
  }
}