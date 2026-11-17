import 'dart:convert';

import 'package:coursera_mobile_app_dev_capstone/features/habits/domain/model/habit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitService {
  static const String _habitsKey = 'habits_data';

  Future<void> saveHabits(List<HabitModel> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = habits.map((h) => h.toMap()).toList();
    await prefs.setString(_habitsKey, jsonEncode(jsonList));
  }

  Future<List<HabitModel>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_habitsKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => HabitModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
