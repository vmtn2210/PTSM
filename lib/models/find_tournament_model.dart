class FindTournamentModel {
  final int id;
  final String tournamentName;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? registrationExpiredDate;
  final List<Location> locations;
  final DateTime creationDate;
  final DateTime? modificationDate;
  final DateTime? deletionDate;
  final String imageUrl;

  FindTournamentModel({
    required this.id,
    required this.tournamentName,
    required this.startDate,
    required this.endDate,
    this.registrationExpiredDate,
    required this.locations,
    required this.creationDate,
    this.modificationDate,
    this.deletionDate,
    required this.imageUrl,
  });

  factory FindTournamentModel.fromJson(Map<String, dynamic> json) {
    return FindTournamentModel(
      id: json['id'],
      tournamentName: json['tournamentName'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      registrationExpiredDate: json['registrationExpiredDate'] != null
          ? DateTime.parse(json['registrationExpiredDate'])
          : null,
      locations: (json['location'] as List<dynamic>)
          .map((loc) => Location.fromJson(loc))
          .toList(),
      creationDate: DateTime.parse(json['creationDate']),
      modificationDate: json['modificationDate'] != null
          ? DateTime.parse(json['modificationDate'])
          : null,
      deletionDate: json['deletionDate'] != null
          ? DateTime.parse(json['deletionDate'])
          : null,
      imageUrl: json['imageUrl'],
    );
  }
}

class Location {
  final int courtGroupId;
  final String courtGroupName;

  Location({required this.courtGroupId, required this.courtGroupName});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      courtGroupId: json['courtGroupId'],
      courtGroupName: json['courtGroupName'],
    );
  }
}
