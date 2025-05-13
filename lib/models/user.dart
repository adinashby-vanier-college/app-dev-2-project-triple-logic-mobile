class User {
  final int id;
  final String email;
  final String? name;
  final String? displayName;
  final String? photoUrl;
  final String? providerId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    this.name,
    this.displayName,
    this.photoUrl,
    this.providerId,
    required this.createdAt,
    this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      name: map['name'] as String?,
      displayName: map['display_name'] as String?,
      photoUrl: map['photo_url'] as String?,
      providerId: map['provider_id'] as String?,
      createdAt: map['created_at'] is DateTime 
        ? map['created_at'] 
        : DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null
        ? (map['updated_at'] is DateTime 
          ? map['updated_at'] 
          : DateTime.parse(map['updated_at']))
        : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'display_name': displayName,
      'photo_url': photoUrl,
      'provider_id': providerId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  User copyWith({
    int? id,
    String? email,
    String? name,
    String? displayName,
    String? photoUrl,
    String? providerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper method to get the display name or fallback to email
  String get displayNameOrEmail => displayName ?? name ?? email;
} 