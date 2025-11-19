import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/modules/header.dart';
import 'package:travelbox/views/modules/footbar.dart';

class Historicocontr extends StatefulWidget {
  const Historicocontr({super.key});

  @override
  _HistoricocontrState createState() => _HistoricocontrState();
}

class _HistoricocontrState extends State<Historicocontr> {
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
                    SizedBox(height: 40.0),
                    Text(
                      'Histórico de Contribuições',
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        color: Color(0xFF333333),
                      ),
                    ),
                    
                    SizedBox(height: 20.0),

                    Text(
                      'Nome do Cofre',
                      style: GoogleFonts.poppins(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),

                    SizedBox(height: 20.0),

                    Card(
                      elevation: 2.0,
                      color: const Color.fromARGB(255, 204, 204, 204),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Text(
                          'Nome do Usuário',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        subtitle: Text(
                          'Data: 01/01/2023',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: Color(0xFF333333),
                          ),
                        ),
                        trailing: Text(
                          'Valor: R\$ 100,00',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: Color(0xFF333333),
                          ),
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


// Main para teste isolado desta tela
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Historicocontr(),
    ),
  ));
}