import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1E90FF),
      child: Stack(
        children: [
          
        Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 120,
                  ),
                  Positioned(
                    top: 32,
                    left: 0,
                    child: Image.asset(
                      'assets/images/logosemletra.png',
                      height: 80,
                    ),
                  ),
                  Positioned(
                    top: 62,
                    right: 0,
                    child: Text(
                      'CofreTrip',
                      style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),






        ],
      ),
    );
  }
}

/*

          
*/
