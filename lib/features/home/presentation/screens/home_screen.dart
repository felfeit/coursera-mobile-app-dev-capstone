import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../../habits/presentation/habit_provider.dart';
import '../../../habits/presentation/widgets/habit_card.dart';
import '../widgets/home_drawer.dart';

/// Main screen showing the user's daily habit progress.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final habitProvider = context.watch<HabitProvider>();
    final userName = auth.currentUser?.name ?? 'User';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      habitProvider.refreshDailyStatus();
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        onPressed: () => context.push('/habits/configure'),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          userName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: habitProvider.isEmpty
          ? const AppEmptyState(
              icon: Icons.checklist_rtl,
              title: 'No habits yet.',
              message: 'Tap the + button to add your first habit.',
            )
          : ListView(
              padding: const EdgeInsets.only(
                top: AppSizes.spacing16,
                bottom: AppSizes.spacing80,
              ),
              children: [
                const AppSectionHeader(title: 'To Do', icon: Icons.edit_note),
                if (habitProvider.todoHabits.isEmpty)
                  const AppEmptyState(
                    message: 'No pending habits. Great job! 🎉',
                    compact: true,
                    compactPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing20,
                      vertical: AppSizes.spacing8,
                    ),
                  ),
                ...habitProvider.todoHabits.map(
                  (habit) => HabitCard(
                    habit: habit,
                    onDismissedDone: () => habitProvider.markAsDone(habit),
                  ),
                ),
                const SizedBox(height: AppSizes.spacing24),
                const AppSectionHeader(
                  title: 'Done',
                  icon: Icons.check_box,
                  iconColor: AppColors.success,
                ),
                if (habitProvider.doneHabits.isEmpty)
                  const AppEmptyState(
                    message: 'No completed habits yet.',
                    compact: true,
                    compactPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing20,
                      vertical: AppSizes.spacing8,
                    ),
                  ),
                ...habitProvider.doneHabits.map(
                  (habit) => HabitCard(
                    habit: habit,
                    onDismissedUndo: () => habitProvider.undoDone(habit),
                  ),
                ),
              ],
            ),
    );
  }
}
