import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelbox/views/modules/footbar.dart';
import 'package:travelbox/views/modules/header.dart';

class HistoricoContr extends StatelessWidget {
  const HistoricoContr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Histórico de Contribuições'),
        backgroundColor: const Color(0xFF1E90FF),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text(
          'Aqui será exibido o histórico de contribuições.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}