import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Displays the available habits as selectable registration chips.
class RegisterHabitSelector extends StatelessWidget {
  final List<String> habits;
  final Set<String> selectedHabits;
  final void Function(String habit, bool selected) onSelectionChanged;

  const RegisterHabitSelector({
    super.key,
    required this.habits,
    required this.selectedHabits,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.selectHabits,
          style: TextStyle(
            color: AppColors.textOnPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacing12),
        Wrap(
          spacing: AppSizes.spacing8,
          runSpacing: AppSizes.spacing8,
          children: habits.map((habit) {
            final isSelected = selectedHabits.contains(habit);
            return FilterChip(
              label: Text(
                habit,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textOnPrimary
                      : AppColors.primary,
                  fontSize: 13,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.primaryLight,
              backgroundColor: AppColors.surface,
              checkmarkColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radius20),
              ),
              onSelected: (selected) => onSelectionChanged(habit, selected),
            );
          }).toList(),
        ),
      ],
    );
  }
}
