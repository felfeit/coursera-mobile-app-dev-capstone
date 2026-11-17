import 'package:coursera_mobile_app_dev_capstone/features/habits/domain/model/habit_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Habit row that supports swipe actions for completion and undo.
class HabitCard extends StatelessWidget {
  final HabitModel habit;
  final VoidCallback? onDismissedDone;
  final VoidCallback? onDismissedUndo;

  const HabitCard({
    super.key,
    required this.habit,
    this.onDismissedDone,
    this.onDismissedUndo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing20,
        vertical: AppSizes.spacing6,
      ),
      child: Dismissible(
        key: ValueKey(habit.id),
        direction: habit.isDone
            ? DismissDirection.startToEnd
            : DismissDirection.endToStart,
        background: _buildSwipeBackground(
          alignment: Alignment.centerLeft,
          color: AppColors.success,
          icon: Icons.check_circle,
          label: 'Undo',
        ),
        secondaryBackground: _buildSwipeBackground(
          alignment: Alignment.centerRight,
          color: AppColors.info,
          icon: Icons.check_circle_outline,
          label: 'Done',
        ),
        onDismissed: (direction) {
          if (habit.isDone) {
            onDismissedUndo?.call();
          } else {
            onDismissedDone?.call();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing20,
            vertical: AppSizes.spacing20,
          ),
          decoration: BoxDecoration(
            color: habit.color,
            borderRadius: BorderRadius.circular(AppSizes.radius16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  habit.name.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.textOnPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (habit.isDone)
                Container(
                  padding: const EdgeInsets.all(AppSizes.spacing4),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 18,
                    color: AppColors.success,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground({
    required Alignment alignment,
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing24,
        vertical: AppSizes.spacing20,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
      ),
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textOnPrimary),
          const SizedBox(width: AppSizes.spacing8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
