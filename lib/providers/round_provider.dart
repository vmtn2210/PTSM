import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/services/round_service.dart';
import 'package:pickle_ball/models/round_model.dart';

final roundsProvider = FutureProvider.family<List<Round>, int>((ref, tournamentId) async {
  return await RoundService.getRounds(tournamentId);
});

final teamsProvider = FutureProvider.family<Map<String, List<TeamGroup>>, int>((ref, tournamentId) async {
  final rounds = await ref.watch(roundsProvider(tournamentId).future);
  if (rounds.isNotEmpty) {
    return await RoundService.getTeamGroups(rounds.first.roundId);
  }
  return {};
});
