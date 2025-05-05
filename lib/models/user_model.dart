class UserModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? email;
  final String? city;
  final String? profilePicUrl;
  final List<String> joinedRoscaIds; // List of ROSCA IDs
  final bool isVerified;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.email,
    this.city,
    this.profilePicUrl,
    this.joinedRoscaIds = const [],
    this.isVerified = false,
  });

  // For Firebase: to/from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '', // Default to an empty string if null
      fullName: map['fullName'] ?? 'Unknown', // Default to 'Unknown' if null
      phoneNumber: map['phoneNumber'] ?? '', // Default to an empty string if null
      email: map['email'], // Nullable, no default needed
      city: map['city'], // Nullable, no default needed
      profilePicUrl: map['profilePicUrl'], // Nullable, no default needed
      joinedRoscaIds: List<String>.from(map['joinedRoscaIds'] ?? []), // Default to an empty list
      isVerified: map['isVerified'] ?? false, // Default to false if null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'city': city,
      'profilePicUrl': profilePicUrl,
      'joinedRoscaIds': joinedRoscaIds,
      'isVerified': isVerified,
    };
  }
}
