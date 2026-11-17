import 'package:coursera_mobile_app_dev_capstone/features/auth/domain/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/password_hasher.dart';
import '../data/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    final loggedIn = await _authService.isLoggedIn();
    if (loggedIn) {
      final username = await _authService.getCurrentUsername();
      if (username != null) {
        _currentUser = await _authService.findUser(username);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String?> register({
    required String name,
    required String username,
    required String password,
    required int age,
    required String country,
    required List<String> habits,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final existing = await _authService.findUser(username);
      if (existing != null) {
        _isLoading = false;
        notifyListeners();
        return 'Username already taken';
      }

      final hashedPwd = PasswordHasher.hashPassword(password);

      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        username: username,
        password: hashedPwd,
        age: age,
        country: country,
        habits: habits,
      );

      await _authService.addUser(user);

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 'Registration failed: $e';
    }
  }

  Future<String?> login({
    required String username,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.findUser(username);
      if (user == null) {
        _isLoading = false;
        notifyListeners();
        return 'No account found. Please register first.';
      }

      if (!PasswordHasher.verifyPassword(password, user.password)) {
        _isLoading = false;
        notifyListeners();
        return 'Invalid username or password';
      }

      _currentUser = user;
      await _authService.setLoggedIn(true, username: username);

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 'Login failed: $e';
    }
  }

  Future<String?> updateProfile({
    required String name,
    required String username,
    required int age,
    required String country,
  }) async {
    if (_currentUser == null) return 'No user logged in';

    _isLoading = true;
    notifyListeners();

    try {
      // Cek username baru bentrok dengan user lain
      if (username.trim().toLowerCase() !=
          _currentUser!.username.toLowerCase()) {
        final existing = await _authService.findUser(username);
        if (existing != null) {
          _isLoading = false;
          notifyListeners();
          return 'Username already taken by another account';
        }
      }

      final updated = _currentUser!.copyWith(
        name: name.trim(),
        username: username.trim(),
        age: age,
        country: country,
      );
      _currentUser = updated;
      await _authService.updateUser(updated);

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 'Failed to update profile: $e';
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _authService.logout();
    notifyListeners();
  }
}
