import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../habits/presentation/habit_provider.dart';
import '../widgets/weekly_report_table.dart';

/// Weekly completion report for the user's habits.
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    final habits = habitProvider.habits;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        title: const Text(
          'Weekly Report',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: habits.isEmpty
            ? const AppEmptyState(
                icon: Icons.bar_chart,
                title: 'No habits to report yet.',
                message: 'Add some habits to start tracking!',
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.spacing16),
                child: WeeklyReportTable(
                  habits: habits,
                  days: DateHelper.weekDates(DateTime.now()),
                  habitProvider: habitProvider,
                ),
              ),
      ),
    );
  }
}
