import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/notification_service.dart';

/// Manages notification preferences and scheduled reminders.
class NotificationProvider extends ChangeNotifier {
  final NotificationService _service = NotificationService();

  bool _enabled = false;
  Set<String> _selectedHabits = {};
  Set<String> _selectedTimes = {};

  bool get enabled => _enabled;
  Set<String> get selectedHabits => _selectedHabits;
  Set<String> get selectedTimes => _selectedTimes;

  static const _kEnabled = 'notif_enabled';
  static const _kHabits = 'notif_habits';
  static const _kTimes = 'notif_times';

  static const int _morningId = 1001;
  static const int _afternoonId = 1002;
  static const int _eveningId = 1003;

  static const int _morningHour = 8;
  static const int _afternoonHour = 13;
  static const int _eveningHour = 20;

  Future<void> init() async {
    await _service.init();
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_kEnabled) ?? false;
    _selectedHabits = (prefs.getStringList(_kHabits) ?? []).toSet();
    _selectedTimes = (prefs.getStringList(_kTimes) ?? []).toSet();
    notifyListeners();
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    await _save();
    if (_enabled) {
      await _scheduleAll();
    } else {
      await _service.cancelAll();
    }
    notifyListeners();
  }

  Future<void> toggleHabit(String habitName) async {
    if (_selectedHabits.contains(habitName)) {
      _selectedHabits.remove(habitName);
    } else {
      _selectedHabits.add(habitName);
    }
    await _save();
    await _rescheduleIfEnabled();
    notifyListeners();
  }

  Future<void> toggleTime(String timeKey) async {
    if (_selectedTimes.contains(timeKey)) {
      _selectedTimes.remove(timeKey);
    } else {
      _selectedTimes.add(timeKey);
    }
    await _save();
    await _rescheduleIfEnabled();
    notifyListeners();
  }

  Future<void> sendTestNotification() async {
    await _service.showNow(
      id: 999,
      title: 'Habitt Reminder',
      body: 'This is a test notification. Time to check your habits!',
    );
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kEnabled, _enabled);
    await prefs.setStringList(_kHabits, _selectedHabits.toList());
    await prefs.setStringList(_kTimes, _selectedTimes.toList());
  }

  Future<void> _rescheduleIfEnabled() async {
    if (_enabled) {
      await _service.cancelAll();
      await _scheduleAll();
    }
  }

  Future<void> _scheduleAll() async {
    if (_selectedHabits.isEmpty || _selectedTimes.isEmpty) return;

    final habitsText = _selectedHabits.join(', ');
    final body = 'Time to: $habitsText';

    if (_selectedTimes.contains('morning')) {
      await _service.scheduleDaily(
        id: _morningId,
        title: 'Good Morning!',
        body: body,
        hour: _morningHour,
        minute: 0,
      );
    }
    if (_selectedTimes.contains('afternoon')) {
      await _service.scheduleDaily(
        id: _afternoonId,
        title: 'Afternoon Check-in',
        body: body,
        hour: _afternoonHour,
        minute: 0,
      );
    }
    if (_selectedTimes.contains('evening')) {
      await _service.scheduleDaily(
        id: _eveningId,
        title: 'Evening Reminder',
        body: body,
        hour: _eveningHour,
        minute: 0,
      );
    }
  }
}
