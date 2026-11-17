import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

enum AppSnackbarType { success, error }

/// Displays a themed success or error message.
class AppSnackbar {
  AppSnackbar._();

  static void show(
    BuildContext context,
    String message,
    AppSnackbarType type, {
    Duration? duration,
  }) {
    final backgroundColor = switch (type) {
      AppSnackbarType.success => AppColors.success,
      AppSnackbarType.error => AppColors.error,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }
}
