class UserProfile {
  final int id;
  final String? fullName;
  final String? dateOfBirth;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final int? rank;
  final String? imageUrl;
  final int status;

  UserProfile({
    required this.id,
    this.fullName,
    this.dateOfBirth,
    this.address,
    this.email,
    this.phoneNumber,
    this.gender,
    this.rank,
    this.imageUrl,
    required this.status,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      fullName: json['fullName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
      rank: json['rank'] as int?,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'rank': rank,
      'imageUrl': imageUrl,
      'status': status,
    };
  }
}
