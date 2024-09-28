import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickle_ball/models/find_tournament_model.dart';
import 'package:pickle_ball/services/api_config.dart';

class FindTournamentService {
  static final String _baseUrl = ApiConfig.fullUrl;

  Future<List<FindTournamentModel>> getTournaments() async {
    final response = await http.get(Uri.parse('$_baseUrl/tournament-campaign'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => FindTournamentModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load tournaments');
    }
  }
}
