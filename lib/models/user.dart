class User {
  final int? id;
  final String name;
  final String email;
  final String? password; // Only used for registration/login, not stored in app
  final bool isAdmin;
  final String? profileImageUrl;
  final String? createdAt;

  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    this.isAdmin = false,
    this.profileImageUrl,
    this.createdAt,
  });

  // Convert User instance to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password, // Only sent for creation/authentication
      'is_admin': isAdmin,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt,
    };
  }

  // Create User instance from a Map (database result)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      isAdmin: map['is_admin'] ?? false,
      profileImageUrl: map['profile_image_url'],
      createdAt: map['created_at'],
    );
  }

  // Create a copy of this User with given fields replaced with new values
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    bool? isAdmin,
    String? profileImageUrl,
    String? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 