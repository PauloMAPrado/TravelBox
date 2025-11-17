import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Linha original //
// import 'package:travelbox/views/PrimeiraTela.dart';

// Linha para teste
import 'package:travelbox/views/criacofre.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // A primeira tela será a 'PrimeiraTela' (Splash Screen).

      // Linha original //
      // home: PrimeiraTela(),

      // Linha para teste
      home: Criacofre(),
      
    );
  }
}