class Athlete {
  final int id;
  final String athleteName;
  final int rank;
  final String gender;
  final String athleteType;
  final int? tournamentId;
  final int? tournamentCampaignId;

  Athlete({
    required this.id,
    required this.athleteName,
    required this.rank,
    required this.gender,
    required this.athleteType,
    this.tournamentId,
    this.tournamentCampaignId,
  });

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      id: json['id'],
      athleteName: json['athleteName'],
      rank: json['rank'],
      gender: json['gender'],
      athleteType: json['athleteType'],
      tournamentId: json['tournamentId'],
      tournamentCampaignId: json['tournamentCampaignId'],
    );
  }
}
