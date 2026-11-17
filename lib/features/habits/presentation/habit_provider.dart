import 'package:coursera_mobile_app_dev_capstone/features/habits/domain/model/habit_model.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/date_helper.dart';
import '../data/habit_service.dart';

class HabitProvider extends ChangeNotifier {
  final HabitService _service = HabitService();
  final List<HabitModel> _habits = [];

  bool _isLoading = true;

  List<HabitModel> get habits => _habits;
  List<HabitModel> get todoHabits => _habits.where((h) => !h.isDone).toList();
  List<HabitModel> get doneHabits => _habits.where((h) => h.isDone).toList();
  bool get isEmpty => _habits.isEmpty;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    _habits.clear();
    final loaded = await _service.loadHabits();
    _habits.addAll(loaded);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _persist() async {
    await _service.saveHabits(_habits);
  }

  bool isHabitNameExists(String name) {
    return _habits.any(
      (h) => h.name.toLowerCase() == name.toLowerCase().trim(),
    );
  }

  String? addHabit(String name, Color color) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'Habit name cannot be empty';
    if (isHabitNameExists(trimmed)) return 'Habit already exists';

    _habits.add(
      HabitModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: trimmed,
        colorValue: color.toARGB32(),
      ),
    );
    notifyListeners();
    _persist();
    return null;
  }

  void markAsDone(HabitModel habit) {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      final today = DateHelper.dateKey(DateTime.now());
      final newHistory = Map<String, bool>.from(_habits[index].history);
      newHistory[today] = true;
      _habits[index] = _habits[index].copyWith(
        isDone: true,
        history: newHistory,
      );
      notifyListeners();
      _persist();
    }
  }

  void undoDone(HabitModel habit) {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      final today = DateHelper.dateKey(DateTime.now());
      final newHistory = Map<String, bool>.from(_habits[index].history);
      newHistory.remove(today);
      _habits[index] = _habits[index].copyWith(
        isDone: false,
        history: newHistory,
      );
      notifyListeners();
      _persist();
    }
  }

  void deleteHabit(String id) {
    _habits.removeWhere((h) => h.id == id);
    notifyListeners();
    _persist();
  }

  bool isDoneOnDate(HabitModel habit, DateTime date) {
    return habit.history[DateHelper.dateKey(date)] ?? false;
  }

  /// Aligns each habit's visible done state with today's history entry.
  void refreshDailyStatus() {
    final today = DateHelper.dateKey(DateTime.now());
    bool changed = false;
    for (var i = 0; i < _habits.length; i++) {
      final habit = _habits[i];
      final isDoneToday = habit.history[today] ?? false;
      if (habit.isDone != isDoneToday) {
        _habits[i] = habit.copyWith(isDone: isDoneToday);
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
      _persist();
    }
  }
}
