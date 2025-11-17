import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/login.dart';
import 'package:travelbox/views/modules/header.dart';

// NOVAS IMPORTAÇÕES NECESSÁRIAS
import '../services/AuthService.dart'; // Para autenticação (Email/Senha)
import '../services/FirestoreService.dart'; // Para salvar dados (Nome, CPF, Tel)
import 'package:firebase_auth/firebase_auth.dart'; // Para o tipo User?

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // --- Controladores ---
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  // --- Serviços e Estado ---
  final AuthService _auth = AuthService();
  final UserService _userService = UserService(); // NOVO: Instância do serviço de dados
  bool _isLoading = false;

  // --- Funções de Feedback ---
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return; 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // --- Lógica Principal de Cadastro ---
  void _handleRegister() async {
    // 1. Inicia o Loading
    setState(() {
      _isLoading = true;
    });

    final String email = _emailController.text.trim();
    final String password = _senhaController.text;
    final String confirmPassword = _confirmarSenhaController.text;

    // 2. Validação local
    if (email.isEmpty || password.isEmpty || _nomeController.text.isEmpty) {
      _showSnackBar('Preencha todos os campos obrigatórios.', isError: true);
      setState(() { _isLoading = false; });
      return;
    }
    if (password != confirmPassword) {
      _showSnackBar('As senhas não coincidem.', isError: true);
      setState(() { _isLoading = false; });
      return;
    }
    if (password.length < 6) { // Regra do Firebase
      _showSnackBar('A senha deve ter pelo menos 6 caracteres.', isError: true);
      setState(() { _isLoading = false; });
      return;
    }

    // 3. Cadastrar no Firebase AUTH
    User? user = await _auth.signUpWithEmail(email, password);

    if (user != null) {
      try {
        // 4. Salvar dados adicionais no Firestore (usando o UID do Firebase Auth)
        await _userService.saveNewUser(
          user.uid,
          _nomeController.text,
          _cpfController.text,
          _telefoneController.text,
        );

        // Cadastro SUCESSO!
        _showSnackBar('Cadastro concluído com sucesso!', isError: false);
        
        // Navega de volta para a tela de Login
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (Route<dynamic> route) => false, // Remove todas as telas anteriores
          );
        }
      } catch (e) {
        // Erro ao salvar dados no Firestore
        _showSnackBar('Erro ao salvar dados. Tente novamente.', isError: true);
        // Opcional: Você pode querer deslogar o usuário criado no Auth aqui
      }

    } else {
      // Cadastro FALHOU no Auth (ex: email já em uso)
      _showSnackBar('Falha no cadastro. O email pode já estar em uso.', isError: true);
    }

    // 5. Finaliza o Loading (se o sucesso/falha não navegarem a tela)
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

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
              decoration: const BoxDecoration( // Adicionado 'const'
                color: Color(0xFFF4F9FB), 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SingleChildScrollView( // NOVO: Para evitar overflow do teclado
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40.0), // Adicionado 'const'

                        //Título
                        Text(
                          'Cadastro de Usuário',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0), // Adicionado 'const'
                          ),
                        ),
                        const SizedBox(height: 50.0), // Adicionado 'const'


                        //Nome
                        TextField(
                          controller: _nomeController, // NOVO: Controlador
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Nome',
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


                        //CPF
                        TextField(
                          controller: _cpfController, // NOVO: Controlador
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
                        const SizedBox(height: 16.0), // Adicionado 'const'


                        //Email
                        TextField(
                          controller: _emailController, // NOVO: Controlador
                          keyboardType: TextInputType.emailAddress,
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
                        const SizedBox(height: 16.0), // Adicionado 'const'


                        //Telefone
                        TextField(
                          controller: _telefoneController, // NOVO: Controlador
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Telefone',
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


                        //Senha
                        TextField(
                          controller: _senhaController, // NOVO: Controlador
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
                        const SizedBox(height: 16.0), // Adicionado 'const'

                        //Confirmar Senha
                        TextField(
                          controller: _confirmarSenhaController, // NOVO: Controlador
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirmar Senha',
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


                        //Botão de Cadastro
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister, // LIGADO À LÓGICA
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E90FF), // Adicionado 'const'
                            padding: const EdgeInsets.symmetric(vertical: 16.0), // Adicionado 'const'
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: _isLoading // Exibir loader se estiver carregando
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                              'Confirmar Cadastro',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, color: Colors.white),
                            ),
                        ),
                        const SizedBox(height: 25), // Adicionado 'const'


                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Já possui uma conta?',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),

                          //Botão Login
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Login()), // Adicionado 'const'
                              );
                            },
                            child: Text(
                              'Logue agora',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 0, 0, 0), // Adicionado 'const'
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 30.0), // Adicionado 'const' para espaçamento inferior

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