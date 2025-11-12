import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/sharecode.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';
import 'package:intl/intl.dart'; 

class Cofre extends StatefulWidget {
  // --- PARÂMETROS OBRIGATÓRIOS RECEBIDOS ---
  final String cofreNome;
  final double valorAlvo;
  final double valorAtual;
  final DateTime dataInicio;
  final String codigoAcesso; 

  const Cofre({
    super.key,
    required this.cofreNome,
    required this.valorAlvo,
    required this.valorAtual,
    required this.dataInicio,
    required this.codigoAcesso,
  });

  @override
  State<Cofre> createState() => _CofreState();
}

class _CofreState extends State<Cofre> {
  // --- Formatação de Moeda e Data ---
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR', 
    symbol: 'R\$',
    decimalDigits: 2,
  );

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  // --- Widgets de Informação Reutilizáveis ---
  Widget _buildInfoCard({required String title, required String value, required IconData icon}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF1E90FF), size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cálculo e Formatação dos Dados do Cofre (usando widget.propriedade)
    // Garante que o progresso está entre 0.0 e 1.0
    double progress = (widget.valorAtual / widget.valorAlvo).clamp(0.0, 1.0);
    double valorRestante = widget.valorAlvo - widget.valorAtual;
    
    String valorAtualFormatado = _currencyFormat.format(widget.valorAtual);
    String valorAlvoFormatado = _currencyFormat.format(widget.valorAlvo);
    String dataInicioFormatada = _dateFormat.format(widget.dataInicio);
    String valorRestanteFormatado = _currencyFormat.format(valorRestante.clamp(0.0, double.infinity));


    return Scaffold(
      backgroundColor: const Color(0xFF1E90FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Header(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF4F9FB), 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30.0),
                    // TÍTULO DO COFRE
                    Text(
                      widget.cofreNome,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // SALDO ATUAL
                    _buildInfoCard(
                      title: 'Saldo Atual',
                      value: valorAtualFormatado,
                      icon: Icons.account_balance_wallet,
                    ),
                    
                    const SizedBox(height: 20),

                    // --- VISUALIZAÇÃO DE PROGRESSO DO COFRE ---
                    Center(
                      child: SizedBox(
                        width: 100, // Define a área do ícone
                        height: 100,
                        child: Stack(
                          children: [
                            // 1. Ícone Cheio (Preenchimento)
                            ClipRect(
                              // Alinha ao topo para que o recorte mostre a parte de baixo (o preenchimento)
                              child: Align(
                                alignment: Alignment.topCenter, 
                                heightFactor: progress, // Controla a altura do preenchimento (0.0 a 1.0)
                                child: const Icon(
                                  Icons.savings,
                                  size: 100,
                                  color: Color(0xFF1E90FF), // Cor do cofre cheio
                                ),
                              ),
                            ),
                            
                            // 2. Ícone Vazio (Contorno/Fundo)
                            // Colocado por cima para dar a sensação de contorno, 
                            // embora com ícones sólidos isso seja um desafio visual.
                            const Icon(
                              Icons.savings,
                              size: 100,
                              color: Colors.grey, // Cor do cofre vazio
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Texto de porcentagem
                    Text(
                      '${(progress * 100).toStringAsFixed(1)}% da Meta alcançada',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1E90FF)),
                    ),
                    const SizedBox(height: 20.0),
                    
                    // INFORMAÇÕES SECUNDÁRIAS (GRID)
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            title: 'Valor Alvo',
                            value: valorAlvoFormatado,
                            icon: Icons.flag,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildInfoCard(
                            title: 'Restante',
                            value: valorRestanteFormatado,
                            icon: Icons.trending_down,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            title: 'Início da Viagem',
                            value: dataInicioFormatada,
                            icon: Icons.calendar_today,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildInfoCard(
                            title: 'Código de Acesso',
                            value: widget.codigoAcesso,
                            icon: Icons.lock_open,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // BOTÃO PRINCIPAL (Adicionar/Ver Itens)
                    ElevatedButton(
                      onPressed: () {
                        // Direcionar para a tela CodigoCofre, passando o código
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CodigoCofre(
                              codigoAcesso: widget.codigoAcesso, // Passando o parâmetro
                            )
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E90FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'Adicionar/Ver Itens',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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