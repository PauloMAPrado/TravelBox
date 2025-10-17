import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Recover extends StatefulWidget {
  const Recover({super.key});

  @override
  _RecoverState createState() => _RecoverState();
}

class _RecoverState extends State<Recover> {

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF1E90FF),
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            //header azul 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 120,
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    child: Image.asset(
                      'assets/images/logosemletra.png',
                      height: 60,
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 0,
                    child: Text(
                      'Senha',
                      style: GoogleFonts.poppins(
                          fontSize: 17.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          //container
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

                      //Título
                      Text(
                        'Recuperação de Senha',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 180.0),


                      //Email
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      SizedBox(height: 16.0),


                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Insira seu email para receber o link de recuperação',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.0),
                    
                    //Enviar
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1E90FF),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Enviar',
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),


                    ],
                  ),
                ),
            ),
          ),
        ],
    ),
  );
}
}
