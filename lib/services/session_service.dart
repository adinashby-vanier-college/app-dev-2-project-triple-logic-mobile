import 'package:flutter/material.dart';
// Comment out the shared_preferences import until it's available
// import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class SessionService {
  static final SessionService _instance = SessionService._internal();
  factory SessionService() => _instance;
  SessionService._internal();

  User? _currentUser;

  Future<void> saveUserSession(User user) async {
    // Using in-memory storage since shared_preferences is not available
    _currentUser = user;
    
    // Implementation with shared_preferences (commented out)
    // final prefs = await SharedPreferences.getInstance();
    // final userJson = user.toMap();
    // await prefs.setString(_userKey, jsonEncode(userJson));
  }

  Future<void> clearUserSession() async {
    // Using in-memory storage
    _currentUser = null;
    
    // Implementation with shared_preferences (commented out)
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove(_userKey);
  }

  Future<User?> getCurrentUser() async {
    // If we have a user in memory, return it
    if (_currentUser != null) {
      return _currentUser;
    }
    
    // Otherwise, fetch the admin user as a fallback
    final userRepository = UserRepository();
    return userRepository.getUserByEmail('admin@24bits.com');
    
    // Implementation with shared_preferences (commented out)
    /*
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson == null) {
      // If no user is logged in, return the admin user as default
      final userRepository = UserRepository();
      return userRepository.getUserByEmail('admin@24bits.com');
    }
    
    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return User.fromMap(userMap);
    } catch (e) {
      print('Error parsing user session: $e');
      // If there's an error parsing the session, return the admin user
      final userRepository = UserRepository();
      return userRepository.getUserByEmail('admin@24bits.com');
    }
    */
  }

  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }
} 