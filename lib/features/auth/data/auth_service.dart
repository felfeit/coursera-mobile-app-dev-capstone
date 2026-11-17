import 'dart:convert';

import 'package:coursera_mobile_app_dev_capstone/features/auth/domain/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'users_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _currentUsernameKey = 'current_username';

  Future<void> _saveAllUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = users.map((u) => u.toMap()).toList();
    await prefs.setString(_usersKey, jsonEncode(jsonList));
  }

  Future<List<UserModel>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_usersKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => UserModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addUser(UserModel newUser) async {
    final users = await getAllUsers();
    users.add(newUser);
    await _saveAllUsers(users);
  }

  Future<UserModel?> findUser(String username) async {
    final users = await getAllUsers();
    try {
      return users.firstWhere(
        (u) => u.username.toLowerCase() == username.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> updateUser(UserModel updatedUser) async {
    final users = await getAllUsers();
    final idx = users.indexWhere((u) => u.username == updatedUser.username);
    if (idx != -1) {
      users[idx] = updatedUser;
    } else {
      users.add(updatedUser);
    }
    await _saveAllUsers(users);
  }

  Future<void> setLoggedIn(bool value, {String? username}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
    if (value && username != null) {
      await prefs.setString(_currentUsernameKey, username);
    } else {
      await prefs.remove(_currentUsernameKey);
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUsernameKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_currentUsernameKey);
  }
}
