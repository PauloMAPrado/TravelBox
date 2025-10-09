import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp (MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrimeiraTela(),
    );
  }
}

// Primeira tela
class PrimeiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F9FB),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 250,
          ),
        ),
      ),
    );
  }
}

