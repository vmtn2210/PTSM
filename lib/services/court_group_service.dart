import 'package:dio/dio.dart';
import 'package:pickle_ball/models/court_group_model.dart';
import 'package:pickle_ball/services/api_config.dart';

class CourtGroupService {
  final Dio _dio = Dio();
  final String _baseUrl = ApiConfig.fullUrl;

  Future<CourtGroup> getCourtGroup(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/courtGroups/1');
      return CourtGroup.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load court group: $e');
    }
  }
}
