import 'package:flutter/material.dart';
import 'views/login.dart';
import 'package:firebase_core/firebase_core.dart';
// Importa o arquivo gerado pelo flutterfire configure:
import 'firebase_options.dart'; 

void main() async {
  // 1. Garante que a ligação entre Flutter e o código nativo esteja pronta.
  WidgetsFlutterBinding.ensureInitialized(); 

  // 2. Inicializa o Firebase com as opções corretas para a plataforma atual.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Inicia o aplicativo.
  runApp(const MyApp());
}
// OBSERVAÇÃO: A FUNÇÃO void main() { runApp (MyApp()); } FOI REMOVIDA PARA EVITAR ERRO DE DUPLICAÇÃO.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // A primeira tela será a 'PrimeiraTela' (Splash Screen).
      home: PrimeiraTela(), 
    );
  }
}

// Primeira tela (Splash Screen)
class PrimeiraTela extends StatelessWidget {
  const PrimeiraTela({super.key});

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