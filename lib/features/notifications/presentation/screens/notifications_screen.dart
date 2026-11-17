import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../habits/presentation/habit_provider.dart';
import '../notifications_provider.dart';

/// Configures reminder preferences and sends a test notification.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();
    final habits = context.watch<HabitProvider>().habits;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
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
                    vertical: AppSizes.spacing8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Enable Notifications',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Switch(
                        value: notificationProvider.enabled,
                        activeThumbColor: AppColors.primary,
                        onChanged: notificationProvider.setEnabled,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spacing24),
              const Text(
                'Select Habits for Notification',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.spacing12),
              if (habits.isEmpty)
                const AppEmptyState(
                  message: 'No habits available. Add habits first.',
                  compact: true,
                  compactPadding: EdgeInsets.zero,
                  compactAlignment: Alignment.centerLeft,
                  compactTextAlign: TextAlign.start,
                )
              else
                Wrap(
                  spacing: AppSizes.spacing8,
                  runSpacing: AppSizes.spacing8,
                  children: habits.map((habit) {
                    final selected = notificationProvider.selectedHabits
                        .contains(habit.name);
                    return FilterChip(
                      label: Text(
                        habit.name,
                        style: TextStyle(
                          color: selected
                              ? AppColors.textOnPrimary
                              : habit.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: selected,
                      onSelected: (_) =>
                          notificationProvider.toggleHabit(habit.name),
                      selectedColor: habit.color,
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radius20),
                        side: BorderSide(color: habit.color),
                      ),
                      checkmarkColor: AppColors.textOnPrimary,
                    );
                  }).toList(),
                ),
              const SizedBox(height: AppSizes.spacing24),
              const Text(
                'Select Times for Notification',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.spacing12),
              Wrap(
                spacing: AppSizes.spacing8,
                runSpacing: AppSizes.spacing8,
                children: [
                  _buildTimeChip(notificationProvider, 'morning', 'Morning'),
                  _buildTimeChip(
                    notificationProvider,
                    'afternoon',
                    'Afternoon',
                  ),
                  _buildTimeChip(notificationProvider, 'evening', 'Evening'),
                ],
              ),
              const SizedBox(height: AppSizes.spacing40),
              CustomButton(
                label: 'Send Test Notification',
                onPressed: notificationProvider.enabled
                    ? notificationProvider.sendTestNotification
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeChip(
    NotificationProvider provider,
    String key,
    String label,
  ) {
    final selected = provider.selectedTimes.contains(key);
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? AppColors.textOnPrimary : AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: selected,
      onSelected: (_) => provider.toggleTime(key),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius20),
        side: const BorderSide(color: AppColors.primary),
      ),
      checkmarkColor: AppColors.textOnPrimary,
    );
  }
}
