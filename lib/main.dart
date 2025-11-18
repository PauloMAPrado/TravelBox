import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travelbox/views/home.dart';
import 'package:travelbox/views/pageSlash.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:travelbox/services/AuthService.dart';
import 'package:travelbox/services/FirestoreService.dart';
import 'package:travelbox/services/authProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreService>(create: (_) => FirestoreService()),

        Provider<AuthService>(
          create: (context) => AuthService(context.read<FirestoreService>()),
        ),

        ChangeNotifierProvider<AuthStore>(
          create: (context) => AuthStore(
            context.read<AuthService>(),
            context.read<FirestoreService>(),
          ),
        ),
      ],
        return child: MaterialApp(
          debugShowCheckedModeBanner: false,

          home: _getTelaInicial(AuthStore.sessionStatus),
        );
      },
    );
  }

  Widget _getTelaInicial(SessionStatus status) {
    switch (status) {
      case SessionStatus.authenticated:
        return Home();
    }
  }
}
