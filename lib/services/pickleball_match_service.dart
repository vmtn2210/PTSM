import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickle_ball/services/api_config.dart';
import '../models/pickleball_match_model.dart';

class PickleballMatchService {
  static final String baseUrl = ApiConfig.fullUrl;

  Future<List<PickleballMatch>> getMatchesByTournamentId(
      int tournamentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pickleball-match/$tournamentId'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => PickleballMatch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pickleball matches');
    }
  }
}
