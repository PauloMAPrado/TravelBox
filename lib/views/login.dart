import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelbox/views/modules/header.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

import 'register.dart';
import 'recover.dart';
import 'home.dart' as home;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; 

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return; 

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleLogin() async {
    // 1. Inicia o Loading
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // 2. Validação simples
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Preencha todos os campos.', isError: true);
      setState(() { _isLoading = false; });
      return;
    }

    // 3. Tenta fazer Login no Firebase e CAPTURA O RESULTADO (CORREÇÃO CRÍTICA)
    User? user;
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = credential.user;
    } on FirebaseAuthException catch (e) {
      // Mostra erro amigável para o usuário
      _showSnackBar(e.message ?? 'Erro ao autenticar.', isError: true);
      user = null;
    } catch (e) {
      // Erro genérico
      _showSnackBar('Erro ao autenticar. Tente novamente.', isError: true);
      user = null;
    }

    // 4. Finaliza o Loading
    setState(() {
      _isLoading = false;
    });
    
    // 5. Processa o Resultado (Verifica se o usuário existe)
    if (user != null) {
      // Login SUCESSO!
      _showSnackBar('Login bem-sucedido!', isError: false);
      
      // Navega para a Home (usando pushReplacement para limpar a tela de login)
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => home.Home()),
        );
      }
    } else {
      // Login FALHOU (o AuthService já imprimiu o erro no console)
      _showSnackBar('Credenciais inválidas. Tente novamente.', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E90FF),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              //header azul 
            Header(),

            //container
            Expanded(
              child: Container(
                decoration: const BoxDecoration( 
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
                        const SizedBox(height: 40.0), 

                        //Título
                        Text(
                          'Login de Usuário',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0), 
                          ),
                        ),
                        const SizedBox(height: 180.0), 


                        //CPF -> USADO COMO EMAIL PARA FIREBASE
                        TextField(
                          controller: _emailController, 
                          keyboardType: TextInputType.emailAddress, 
                          decoration: InputDecoration(
                            labelText: 'Email', // MUDANÇA
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(height: 16.0), 


                        //Senha
                        TextField(
                          controller: _passwordController, 
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
                        const SizedBox(height: 10.0), 


                        //Recuperação de senha
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Recover()), 
                              );
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
                        const SizedBox(height: 25), 


                        //Login
                        ElevatedButton(
                          // LIGAÇÃO DA FUNÇÃO CORRIGIDA
                          onPressed: _isLoading ? null : _handleLogin, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E90FF), 
                            padding: const EdgeInsets.symmetric(vertical: 16.0), 
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
                                  'Login',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                        const SizedBox(height: 25), 


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
                                MaterialPageRoute(builder: (context) => const Register()), 
                              );
                            },
                            child: Text(
                              'Cadastre-se',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 0, 0, 0),
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
  // LIMPEZA: Disposer os controladores
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}