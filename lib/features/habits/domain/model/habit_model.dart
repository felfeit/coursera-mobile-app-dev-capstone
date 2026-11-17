import 'package:flutter/material.dart';

class HabitModel {
  final String id;
  final String name;
  final int colorValue;
  final bool isDone;
  final Map<String, bool> history;

  HabitModel({
    required this.id,
    required this.name,
    required this.colorValue,
    this.isDone = false,
    Map<String, bool>? history,
  }) : history = history ?? {};

  Color get color => Color(colorValue);

  HabitModel copyWith({
    String? id,
    String? name,
    int? colorValue,
    bool? isDone,
    Map<String, bool>? history,
  }) {
    return HabitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      isDone: isDone ?? this.isDone,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'colorValue': colorValue,
      'isDone': isDone,
      'history': history,
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      colorValue: map['colorValue'] ?? 0xFF4373C7,
      isDone: map['isDone'] ?? false,
      history: Map<String, bool>.from(map['history'] ?? {}),
    );
  }
}
