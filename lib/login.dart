import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF1E90FF),
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //header azul
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 120,
              ),
              Positioned(
                top: 50,
                child: Image.asset(
                  'assets/images/logosemletra.png',
                  height: 60,
                ),
              ),
            ],
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
                        'Login de Usuário',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 180.0),


                      //CPF
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CPF',
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


                      //Senha
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      SizedBox(height: 10.0),


                      //Recuperação de senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                          },
                          child: Text(
                            'Recuperação de Senha',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),


                      //Login
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
                          'Login',
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 25),


                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não tem uma conta?',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),

                        //Botão
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            );
                          },
                          child: Text(
                            'Cadastre-se',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Color.fromARGB(255, 0, 0, 0),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
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