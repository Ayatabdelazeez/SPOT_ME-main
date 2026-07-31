import 'dart:convert';
import 'package:http/http.dart' as http;

class CvApiService {
  static const String baseUrl = 'https://distress-hardship-victory.ngrok-free.dev';

  // هيدرز موحدة لكل الـ Requests عشان المتصفح يقبلها
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // 1. start Interview
  static Future<Map<String, dynamic>> startInterview() async {
    final response = await http.post(
      Uri.parse('$baseUrl/start'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to start interview');
    }
  }

  // 2. Send Response 
  static Future<Map<String, dynamic>> sendAnswer({
    required String sessionId,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: _headers,
      body: jsonEncode({
        'session_id': sessionId,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send answer');
    }
  }

  // 3. CV Generator 
  static Future<Map<String, dynamic>> generateCv(String sessionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generate'),
      headers: _headers,
      body: jsonEncode({
        'session_id': sessionId,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to generate CV');
    }
  }
}