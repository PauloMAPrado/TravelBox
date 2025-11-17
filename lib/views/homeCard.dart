import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/criacofre.dart';
import 'package:travelbox/views/entracofre.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E90FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
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
                    // Card para um cofre existente com Nome, Valor Alvo e Progresso
                    HomeCard(
                      cofreNome: 'Viagem para Paris',
                      valorAlvo: 5000.0,
                      valorAtual: 1500.0,
                    ),

                    SizedBox(height: 20.0),
                    // Botão para criar um novo cofre
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Criacofre()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E90FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'Criar Novo Cofre',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Footbarr(),

        ],
     ),
);
}
}

class HomeCard extends StatelessWidget {
  final String cofreNome;
  final double valorAlvo;
  final double valorAtual;

  const HomeCard({
    Key? key,
    required this.cofreNome,
    required this.valorAlvo,
    required this.valorAtual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress =
        (valorAlvo == 0) ? 0.0 : (valorAtual / valorAlvo).clamp(0.0, 1.0);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cofreNome,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8.0,
              color: Color(0xFF1E90FF),
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R\$ ${valorAtual.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(fontSize: 14.0),
                ),
                Text(
                  'Meta: R\$ ${valorAlvo.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}