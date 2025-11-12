import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // NOVO: Import para a função de copiar
import 'package:google_fonts/google_fonts.dart';

// Importe aqui a tela de adicionar itens que você criará (exemplo: 'adicionar_item.dart')
// import 'adicionar_item.dart'; 

// Esta é a classe que você está navegando:
class CodigoCofre extends StatelessWidget {
  final String codigoAcesso; // NOVO: Recebe o código do construtor

  const CodigoCofre({
    super.key,
    required this.codigoAcesso,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Opções do Cofre', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: const Color(0xFF1E90FF),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Código de Acesso para Compartilhamento:',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            // 1. EXIBIÇÃO DO CÓDIGO
            Card(
              elevation: 4,
              color: const Color(0xFFE3F2FD),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  codigoAcesso,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E90FF),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 2. BOTÃO COPIAR CÓDIGO
            ElevatedButton.icon(
              onPressed: () {
                // LÓGICA DE COPIAR PARA A ÁREA DE TRANSFERÊNCIA
                Clipboard.setData(ClipboardData(text: codigoAcesso));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Código copiado para a área de transferência!')),
                );
              },
              icon: const Icon(Icons.copy, color: Colors.white),
              label: Text(
                'Copiar Código',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E90FF),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            
            const SizedBox(height: 50),
            
            Text(
              'Ações',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            
            // 3. BOTÃO ADICIONAR ITENS (NOVA FUNCIONALIDADE)
            ElevatedButton.icon(
              onPressed: () {
                // ATENÇÃO: Você deve criar a tela AdicionarItem.dart
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AdicionarItem()),
                // );
                
                // Exemplo de notificação (substitua pela navegação real)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navegando para a tela de Adicionar Transação...')),
                );
              },
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFF1E90FF)),
              label: Text(
                'Adicionar Transação/Item',
                style: GoogleFonts.poppins(fontSize: 18, color: const Color(0xFF1E90FF)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF1E90FF), width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}