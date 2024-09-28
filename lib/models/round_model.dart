class Round {
  final int roundId;
  final int roundOrder;
  final String roundName;
  final int tournamentId;
  final String tournamentName;
  final String roundStatus;

  Round({
    required this.roundId,
    required this.roundOrder,
    required this.roundName,
    required this.tournamentId,
    required this.tournamentName,
    required this.roundStatus,
  });

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      roundId: json['roundId'],
      roundOrder: json['roundOrder'],
      roundName: json['roundName'],
      tournamentId: json['tournamentId'],
      tournamentName: json['tournamentName'],
      roundStatus: json['roundStatus'],
    );
  }
}

class TeamGroup {
  final int teamId;
  final String teamName;
  final int wins;
  final int losses;
  final int draws;
  final int points;
  final int setDifference;
  final int pointsDifference;
  final String teamStatus;
  final int teamRoundGroupId;

  TeamGroup({
    required this.teamId,
    required this.teamName,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.points,
    required this.setDifference,
    required this.pointsDifference,
    required this.teamStatus,
    required this.teamRoundGroupId,
  });

  factory TeamGroup.fromJson(Map<String, dynamic> json) {
    return TeamGroup(
      teamId: json['teamId'] ?? 0,
      teamName: json['teamName'] ?? '',
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      draws: json['draws'] ?? 0,
      points: json['points'] ?? 0,
      setDifference: json['setDifference'] ?? 0,
      pointsDifference: json['pointsDifference'] ?? 0,
      teamStatus: json['teamStatus'] ?? '',
      teamRoundGroupId: json['teamRoundGroupId'] ?? 0,
    );
  }
}
