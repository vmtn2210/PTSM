class CourtGroup {
  final int id;
  final String? courtGroupName;
  final String? address;
  final String? emailContact;
  final String? phoneNumber;
  final bool isDeleted;
  final String? latitude;
  final String? longitude;

  CourtGroup({
    required this.id,
    this.courtGroupName,
    this.address,
    this.emailContact,
    this.phoneNumber,
    required this.isDeleted,
    this.latitude,
    this.longitude,
  });

  factory CourtGroup.fromJson(Map<String, dynamic> json) {
    return CourtGroup(
      id: json['id'],
      courtGroupName: json['courtGroupName'],
      address: json['address'],
      emailContact: json['emailContact'],
      phoneNumber: json['phoneNumber'],
      isDeleted: json['isDeleted'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
