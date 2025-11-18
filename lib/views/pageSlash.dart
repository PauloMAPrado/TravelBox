import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/login.dart';

// Primeira tela (Splash Screen)
class TelaSplash extends StatelessWidget {
  const TelaSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FB),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Navega para a tela de Login ao tocar em qualquer lugar
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        // Conteúdo central com logo e texto "Carregando..."
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 250,
            ),
            const SizedBox(height: 20),

            CircularProgressIndicator(),
            
            const SizedBox(height: 16),

            Text(
              'Carregando...',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF2F2F2F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


