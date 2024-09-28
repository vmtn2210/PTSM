import 'package:http/http.dart' as http;
import 'package:pickle_ball/services/api_config.dart';
import 'package:pickle_ball/services/auth_service.dart';

class CampaignRegistrationService {
  static const String _baseUrl = ApiConfig.baseUrl;
  final AuthService _authService = AuthService();

  Future<bool> registerForCampaign(int campaignId) async {
    final token = await _authService.getToken();
    final userId = await _authService.getUserId();

    if (token == null || userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/api/campaign-registration/user/$campaignId'),
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
      throw Exception('Failed to register for campaign');
    }
  }
}
