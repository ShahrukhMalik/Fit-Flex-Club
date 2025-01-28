import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static final String _apiUrl =
      "https://exercisedb.p.rapidapi.com/exercises/exercise/"; // Replace 0001 with your desired ID
  static final String _apiHost = "exercisedb.p.rapidapi.com";
  static final String _apiKey =
      "d0a92c1ffbmsh240211b39e80da0p195d4ajsnce119cd2d091";

  static Future<String?> fetchGifUrl(String exerciseCode) async {
    try {
      final response = await http.get(
        Uri.parse(_apiUrl + exerciseCode.padLeft(4, '0')),
        headers: {
          'x-rapidapi-host': _apiHost,
          'x-rapidapi-key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['gifUrl'];
      } else {
        return '';
      }
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }
}
