import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/athletes_model.dart';
import '../services/athletes_service.dart';

final athletesProvider =
    FutureProvider.family<List<Athlete>, int>((ref, campaignId) async {
  final athletesService = AthletesService();
  return await athletesService.getAthletesByCampaign(campaignId);
});

final athleteByIdProvider =
    FutureProvider.family<List<Athlete>, int>((ref, athleteId) async {
  final athletesService = AthletesService();
  final athletes = await athletesService.getAthleteById(athleteId);
  if (athletes.isEmpty) {
    throw Exception('Athlete not found');
  }
  return athletes;
});
