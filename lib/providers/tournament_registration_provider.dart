import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/services/tournament_registration_service.dart';

final tournamentRegistrationProvider =
    Provider((ref) => TournamentRegistrationService());

final tournamentRegistrationStateProvider =
    StateProvider<AsyncValue<bool>>((ref) => const AsyncValue.data(false));
