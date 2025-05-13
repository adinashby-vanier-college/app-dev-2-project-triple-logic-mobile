import 'package:postgres/postgres.dart';
import '../models/user.dart';

class UserRepository {
  final PostgreSQLConnection _connection;

  UserRepository(this._connection);

  Future<User?> getUserByEmail(String email) async {
    try {
      final results = await _connection.mappedResultsQuery(
        'SELECT * FROM users WHERE email = @email',
        substitutionValues: {
          'email': email,
        },
      );

      if (results.isEmpty) return null;

      final userData = results.first['users']!;
      return User.fromMap(userData);
    } catch (e) {
      print('Error getting user by email: $e');
      return null;
    }
  }

  Future<User?> createUser({
    required String email,
    required String password,
    String? name,
    String? displayName,
    String? photoUrl,
    String? providerId,
  }) async {
    try {
      final results = await _connection.mappedResultsQuery(
        '''
        INSERT INTO users (email, password_hash, name, display_name, photo_url, provider_id)
        VALUES (@email, @password, @name, @displayName, @photoUrl, @providerId)
        RETURNING *
        ''',
        substitutionValues: {
          'email': email,
          'password': password, // Note: In production, this should be hashed
          'name': name,
          'displayName': displayName,
          'photoUrl': photoUrl,
          'providerId': providerId,
        },
      );

      if (results.isEmpty) return null;

      final userData = results.first['users']!;
      return User.fromMap(userData);
    } catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }

  Future<User?> updateUser(int userId, Map<String, dynamic> updates) async {
    try {
      final setClause = updates.keys.map((key) => '$key = @$key').join(', ');
      final query = 'UPDATE users SET $setClause WHERE id = @userId RETURNING *';
      
      final substitutionValues = {...updates, 'userId': userId};

      final results = await _connection.mappedResultsQuery(
        query,
        substitutionValues: substitutionValues,
      );

      if (results.isEmpty) return null;

      final userData = results.first['users']!;
      return User.fromMap(userData);
    } catch (e) {
      print('Error updating user: $e');
      return null;
    }
  }

  Future<bool> deleteUser(int userId) async {
    try {
      final result = await _connection.execute(
        'DELETE FROM users WHERE id = @userId',
        substitutionValues: {
          'userId': userId,
        },
      );
      return result > 0;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }
} 