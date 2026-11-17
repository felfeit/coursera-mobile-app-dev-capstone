import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/model/habit_model.dart';

/// Displays a configured habit and its delete action.
class ConfiguredHabitTile extends StatelessWidget {
  final HabitModel habit;
  final VoidCallback onDelete;

  const ConfiguredHabitTile({
    super.key,
    required this.habit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacing10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radius12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing16,
            vertical: AppSizes.spacing14,
          ),
          child: Row(
            children: [
              Container(
                width: AppSizes.spacing20,
                height: AppSizes.spacing20,
                decoration: BoxDecoration(
                  color: habit.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSizes.spacing14),
              Expanded(
                child: Text(
                  habit.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
