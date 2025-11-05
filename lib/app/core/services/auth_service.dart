import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:8080/api'; // verificar

  // Login por CPF
  static Future<Map<String, dynamic>> login({
    required String cpf,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'cpf': cpf,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Login realizado com sucesso!',
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'CPF ou senha incorretos',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }

  // Registrar usuário
  static Future<Map<String, dynamic>> register({
    required String name,
    required String cpf,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'cpf': cpf,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Usuário cadastrado com sucesso!',
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Erro no cadastro: ${response.body}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }
}