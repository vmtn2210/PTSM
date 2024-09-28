import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickle_ball/services/api_config.dart';
import '../models/athletes_model.dart';

class AthletesService {
  static final String baseUrl = ApiConfig.fullUrl;

  Future<List<Athlete>> getAthletesByCampaign(int campaignId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/athletes/campaign/$campaignId'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Athlete.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load athletes');
    }
  }

  Future<List<Athlete>> getAthleteById(int athleteId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/athletes/$athleteId'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Athlete.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load athletes');
    }
  }
}
