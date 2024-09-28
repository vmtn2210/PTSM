class PickleballMatch {
  final int matchId;
  final int tournamentId;
  final int roundId;
  final int roundOrder;
  final int roundGroupId;
  final int matchOrder;
  final int firstTeamId;
  final String firstTeam;
  final int secondTeamId;
  final String secondTeam;
  final int winningTeamId;
  final String winningTeam;
  final int winConditionId;
  final DateTime matchDate;
  final String? court;
  final String winCondition;
  final int numberOfSet;
  final String matchStatus;

  PickleballMatch({
    required this.matchId,
    required this.tournamentId,
    required this.roundId,
    required this.roundOrder,
    required this.roundGroupId,
    required this.matchOrder,
    required this.firstTeamId,
    required this.firstTeam,
    required this.secondTeamId,
    required this.secondTeam,
    required this.winningTeamId,
    required this.winningTeam,
    required this.winConditionId,
    required this.matchDate,
    this.court,
    required this.winCondition,
    required this.numberOfSet,
    required this.matchStatus,
  });

  factory PickleballMatch.fromJson(Map<String, dynamic> json) {
    return PickleballMatch(
      matchId: json['matchId'],
      tournamentId: json['tournamentId'],
      roundId: json['roundId'],
      roundOrder: json['roundOrder'],
      roundGroupId: json['roundGroupId'],
      matchOrder: json['matchOrder'],
      firstTeamId: json['firstTeamId'],
      firstTeam: json['firstTeam'],
      secondTeamId: json['secondTeamId'],
      secondTeam: json['secondTeam'],
      winningTeamId: json['winningTeamId'],
      winningTeam: json['winningTeam'],
      winConditionId: json['winConditionId'],
      matchDate: DateTime.parse(json['matchDate']),
      court: json['court'],
      winCondition: json['winCondition'],
      numberOfSet: json['numberOfSet'],
      matchStatus: json['matchStatus'],
    );
  }
}
