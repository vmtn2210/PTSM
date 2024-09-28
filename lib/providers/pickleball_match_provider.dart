import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pickleball_match_model.dart';
import '../services/pickleball_match_service.dart';

final pickleballMatchProvider =
    FutureProvider.family<List<PickleballMatch>, int>(
        (ref, tournamentId) async {
  final pickleballMatchService = PickleballMatchService();
  return await pickleballMatchService.getMatchesByTournamentId(tournamentId);
});
