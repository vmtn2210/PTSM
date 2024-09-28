import 'package:http/http.dart' as http;
import 'package:pickle_ball/services/api_config.dart';
import 'package:pickle_ball/services/auth_service.dart';

class TournamentRegistrationService {
  static const String _baseUrl = ApiConfig.baseUrl;
  final AuthService _authService = AuthService();

  Future<bool> registerForTournament(int tournamentId) async {
    final token = await _authService.getToken();
    final userId = await _authService.getUserId();

    if (token == null || userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.post(
      Uri.parse(
          '$_baseUrl/api/tournament-registration/user?tournamentId=$tournamentId'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    } else {
      throw Exception('Failed to register for tournament');
    }
  }
}
