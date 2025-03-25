class PatientProfile {
  final String id;
  final String prenom;
  final String email;
  final String telephone;
  bool isEmailVerified;
  bool isPhoneVerified;
  DateTime createdAt;
  DateTime? lastModifiedAt;

  PatientProfile({
    required this.id,
    required this.prenom,
    required this.email,
    required this.telephone,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    DateTime? createdAt,
    this.lastModifiedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'createdAt': createdAt.toIso8601String(),
      'lastModifiedAt': lastModifiedAt?.toIso8601String(),
    };
  }

  factory PatientProfile.fromMap(Map<String, dynamic> map) {
    return PatientProfile(
      id: map['id'],
      prenom: map['prenom'],
      email: map['email'],
      telephone: map['telephone'],
      isEmailVerified: map['isEmailVerified'] ?? false,
      isPhoneVerified: map['isPhoneVerified'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      lastModifiedAt: map['lastModifiedAt'] != null
          ? DateTime.parse(map['lastModifiedAt'])
          : null,
    );
  }

  PatientProfile copyWith({
    String? prenom,
    String? email,
    String? telephone,
    bool? isEmailVerified,
    bool? isPhoneVerified,
  }) {
    return PatientProfile(
      id: id,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      createdAt: createdAt,
      lastModifiedAt: DateTime.now(),
    );
  }
}
