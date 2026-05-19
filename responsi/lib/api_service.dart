import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://www.freetogame.com/api';

  // Fetch semua game
  static Future<List<dynamic>> fetchGames() async {
    final response = await http.get(Uri.parse('$baseUrl/games'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load games');
    }
  }

  // Fetch detail game berdasarkan ID
  static Future<Map<String, dynamic>> fetchGameDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/game?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load game detail');
    }
  }
}