import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/criacofre.dart';
import 'package:travelbox/views/entracofre.dart';
import 'settings.dart';
import 'account.dart';
import 'premium.dart';

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
          //header azul
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(width: double.infinity, height: 120),
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
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 250.0),
                      Text(
                        'Aparentemente você não tem um cofre criado...',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 18.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                      SizedBox(height: 40.0),
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
                          'Criar Cofre',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Entracofre()),
                            );                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 179, 72), // cor correta hex FFB448

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: Text(
                          'Entre com um código',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0),
                    
                      Spacer(),
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.settings, color: Color(0xFF1E90FF)),
                              iconSize: 40,
                              onPressed: () {
                                Navigator.pushNamed(context, 'settings');
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.account_circle, color: Color(0xFF1E90FF)),
                              iconSize: 40,
                              onPressed: () {
                                Navigator.pushNamed(context, 'account');
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.star, color: Color(0xFF1E90FF)),
                              iconSize: 40,
                              onPressed: () {
                                Navigator.pushNamed(context, 'premium');
                              },
                            ),
                          ],
                        ),
                      ),
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
