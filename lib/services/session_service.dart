import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'package:postgres/postgres.dart';

class SessionService extends ChangeNotifier {
  User? _currentUser;
  final SharedPreferences _prefs;
  final UserRepository _userRepository;
  
  SessionService(this._prefs, PostgreSQLConnection connection) 
    : _userRepository = UserRepository(connection);

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    try {
      final user = await _userRepository.getUserByEmail(email);
      
      if (user != null) {
        // In a real app, verify password hash here
        _currentUser = user;
        await _saveSession(user);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> registerUser({
    required String email,
    required String password,
    String? displayName,
    String? photoUrl,
    String? providerId,
  }) async {
    try {
      final user = await _userRepository.createUser(
        email: email,
        password: password,
        displayName: displayName,
        photoUrl: photoUrl,
        providerId: providerId,
      );

      if (user != null) {
        _currentUser = user;
        await _saveSession(user);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _clearSession();
    notifyListeners();
  }

  Future<void> _saveSession(User user) async {
    await _prefs.setString('user_email', user.email);
    await _prefs.setInt('user_id', user.id);
  }

  Future<void> _clearSession() async {
    await _prefs.remove('user_email');
    await _prefs.remove('user_id');
  }

  Future<bool> restoreSession() async {
    final userEmail = _prefs.getString('user_email');
    if (userEmail != null) {
      final user = await _userRepository.getUserByEmail(userEmail);
      if (user != null) {
        _currentUser = user;
        notifyListeners();
        return true;
      }
    }
    return false;
  }
} 