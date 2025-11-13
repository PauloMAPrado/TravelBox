import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Imports que você forneceu:
import 'package:travelbox/views/login.dart';
import 'package:travelbox/views/modules/header.dart';

class Remake extends StatefulWidget {
  const Remake({super.key});

  @override
  _RemakeState createState() => _RemakeState();
}

class _RemakeState extends State<Remake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E90FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Header(), // Adicionado 'const'

          //container
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                // Adicionado 'const'
                color: Color(0xFFF4F9FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40.0), 

                      //Título
                      Text(
                        'Alterar Senha',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0), 
                        ),
                      ),
                      const SizedBox(height: 180.0), 

                      //Senha
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Nova senha',
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16.0), // Adicionado 'const'

                      //Confirmar Senha
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirmar nova senha',
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 45.0), // Adicionado 'const'

                      ElevatedButton(
                        onPressed: () {
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E90FF),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Confirmar Senha',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}