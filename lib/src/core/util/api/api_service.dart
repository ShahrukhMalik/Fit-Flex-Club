import 'dart:convert';
import 'dart:typed_data';

import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_gif_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _apiUrl =
      "https://exercisedb.p.rapidapi.com/exercises/exercise/"; // Replace 0001 with your desired ID
  static final String _apiHost = "exercisedb.p.rapidapi.com";
  static final String _apiKey =
      "04d6975ed8msh7c8bb7174f49a66p182d6ejsn39dfe364c0a5";

  static Future<ExerciseGifModel> fetchGifUrl(String exerciseCode) async {
    try {
      final response = await http.get(
        Uri.parse(_apiUrl + exerciseCode.padLeft(4, '0')),
        headers: {
          'x-rapidapi-host': _apiHost,
          'x-rapidapi-key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        return ExerciseGifModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          errorMessage: json.decode(response.body)['message'],
        );
      }
    } catch (e) {
      if (e.runtimeType == ServerException) {
        throw ServerException(
          errorMessage: (e as ServerException).errorMessage,
        );
      } else {
        throw ServerException(errorMessage: e.toString());
      }
    }
  }

  Future<Uint8List?> getUint8ListFromNetworkUrl(String? url) async {
    try {
      if (url == null) return null;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes; // This is the Uint8List
      } else {
        throw ServerException(
          errorMessage: 'Failed to load data: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }
}
