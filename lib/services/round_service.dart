import 'package:dio/dio.dart';
import 'package:pickle_ball/models/round_model.dart';
import 'package:pickle_ball/services/api_config.dart';

class RoundService {
  static final Dio _dio = Dio();

  static Future<List<Round>> getRounds(int tournamentId) async {
    try {
      final response =
          await _dio.get('${ApiConfig.fullUrl}/round/$tournamentId');
      if (response.data['success']) {
        return (response.data['data'] as List)
            .map((json) => Round.fromJson(json))
            .toList();
      }
      throw Exception(response.data['message']);
    } catch (e) {
      throw Exception('Failed to fetch rounds: $e');
    }
  }

  static Future<Map<String, List<TeamGroup>>> getTeamGroups(int roundId) async {
    try {
      final response = await _dio
          .get('${ApiConfig.fullUrl}/team-group/ranked-team/$roundId');
      if (response.data is Map<String, dynamic>) {
        Map<String, List<TeamGroup>> result = {};
        response.data.forEach((key, value) {
          if (value is List) {
            result[key.toString()] = value.map((json) => TeamGroup.fromJson(json)).toList();
          }
        });
        return result;
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch team groups: $e');
    }
  }
}
