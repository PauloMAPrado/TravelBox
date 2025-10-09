import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF1E90FF),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 80,
              ),
              Positioned(
                top: 10,
                child: Image.asset(
                  'assets/images/logosemletra.png',
                  height: 60,
                ),
              ),
            ],
          ),         
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Travel Box',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                              Image.asset(
                                'assets/images/logosemletra.png',
                                width: 100,
                                height: 100,
                              ),
                            SizedBox(height: 16),
                            Text(
                              'TRAVEL BOX',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 30),
                            ),
                            Text(
                              '\n\n Planejando a viagem dos seus sonhos? Não deixe que a preocupação com dinheiro atrapalhe! O Travel Box é o seu assistente financeiro pessoal, criado para simplificar o controle de despesas em suas aventuras pelo mundo. \n',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrimeiraTela()),
                        );
                      },
                      child: Text('Voltar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    ),
  );
}
}
