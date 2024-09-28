import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/models/find_tournament_model.dart';
import 'package:pickle_ball/services/find_tournament_service.dart';

final findTournamentProvider =
    StateNotifierProvider<FindTournamentNotifier, FindTournamentState>((ref) {
  return FindTournamentNotifier(FindTournamentService());
});

class FindTournamentNotifier extends StateNotifier<FindTournamentState> {
  final FindTournamentService _service;
  List<FindTournamentModel> _allTournaments = [];

  FindTournamentNotifier(this._service) : super(FindTournamentState.initial());

  Future<void> fetchTournaments() async {
    state = state.copyWith(isLoading: true);

    try {
      _allTournaments = await _service.getTournaments();
      state = state.copyWith(tournaments: _allTournaments, isLoading: false);
    } catch (e) {
      print('Error fetching tournaments: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void searchTournaments(String query) {
    if (query.isEmpty) {
      state = state.copyWith(tournaments: _allTournaments);
    } else {
      final filteredTournaments = _allTournaments.where((tournament) {
        return tournament.tournamentName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            tournament.locations.any((location) => location.courtGroupName
                .toLowerCase()
                .contains(query.toLowerCase()));
      }).toList();
      state = state.copyWith(tournaments: filteredTournaments);
    }
  }
}

class FindTournamentState {
  final List<FindTournamentModel> tournaments;
  final bool isLoading;

  FindTournamentState({required this.tournaments, required this.isLoading});

  FindTournamentState.initial()
      : tournaments = [],
        isLoading = false;

  FindTournamentState copyWith({
    List<FindTournamentModel>? tournaments,
    bool? isLoading,
  }) {
    return FindTournamentState(
      tournaments: tournaments ?? this.tournaments,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
