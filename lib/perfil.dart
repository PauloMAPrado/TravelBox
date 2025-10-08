import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _LoginState extends State<Perfil> {
  //controla o estado do checkbox
  bool check = false;

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF1E90FF),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // PARTE 1: O HEADER AZUL (permanece como estava)
          Stack(
            alignment: Alignment.center,
            children: [
              // O container azul aqui é importante para definir a altura do header
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
        
          // Na segunda tela deve ter um título no AppBar, um Card com ícone ou imagem e um texto. Deve existir um botão para voltar à tela inicial.
          
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
                      'Login',
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

                           // transformar em botão clicável que redireciona para a tela de login
                          
                          children: [
                            Icon(Icons.person, size: 80, color: Colors.blue),
                            SizedBox(height: 16),
                            Text(
                              'Bem-vindo de volta! Faça login para continuar.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Navega para a tela inicial
                        Navigator.pop(context);
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
