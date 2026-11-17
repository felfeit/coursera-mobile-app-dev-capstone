import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_button.dart';

/// Form card for entering a habit and selecting its color.
class HabitFormCard extends StatelessWidget {
  final TextEditingController controller;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;
  final VoidCallback onAdd;

  const HabitFormCard({
    super.key,
    required this.controller,
    required this.selectedColor,
    required this.onColorSelected,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Habit Name',
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacing16,
                  vertical: AppSizes.spacing14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radius12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spacing16),
            const Text(
              'Select Color:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSizes.spacing8),
            Row(
              children: AppColors.habitPalette.map((color) {
                final isSelected = color == selectedColor;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSizes.spacing8),
                  child: GestureDetector(
                    onTap: () => onColorSelected(color),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(
                                color: AppColors.selectionBorder,
                                width: 3,
                              )
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: AppColors.textOnPrimary,
                              size: 22,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSizes.spacing16),
            CustomButton(label: 'Add Habit', onPressed: onAdd),
          ],
        ),
      ),
    );
  }
}
