import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../habits/domain/model/habit_model.dart';
import '../../../habits/presentation/habit_provider.dart';

/// Table of weekly completion status for a collection of habits.
class WeeklyReportTable extends StatelessWidget {
  final List<HabitModel> habits;
  final List<DateTime> days;
  final HabitProvider habitProvider;

  const WeeklyReportTable({
    super.key,
    required this.habits,
    required this.days,
    required this.habitProvider,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radius12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const _WeeklyReportHeader(),
          const Divider(height: 1),
          ...habits.indexed.map(
            (entry) => Column(
              children: [
                _HabitReportRow(
                  habit: entry.$2,
                  days: days,
                  habitProvider: habitProvider,
                ),
                if (entry.$1 < habits.length - 1)
                  const Divider(
                    height: 1,
                    indent: AppSizes.spacing16,
                    endIndent: AppSizes.spacing16,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyReportHeader extends StatelessWidget {
  const _WeeklyReportHeader();

  @override
  Widget build(BuildContext context) {
    const dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing12,
        vertical: AppSizes.spacing14,
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Text(
              'Habit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ...dayLabels.map(
            (label) => Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitReportRow extends StatelessWidget {
  final HabitModel habit;
  final List<DateTime> days;
  final HabitProvider habitProvider;

  const _HabitReportRow({
    required this.habit,
    required this.days,
    required this.habitProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing12,
        vertical: AppSizes.spacing14,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              habit.name,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...days.map((day) {
            final isDone = habitProvider.isDoneOnDate(habit, day);
            return Expanded(
              child: Center(
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isDone
                        ? AppColors.success
                        : AppColors.reportIncomplete,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDone ? Icons.check : Icons.close,
                    color: AppColors.textOnPrimary,
                    size: 14,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
