import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api'; // verificar

  static Future<Map<String, dynamic>> registerUser({
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