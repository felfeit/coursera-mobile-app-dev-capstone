import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/app_dialogs.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../habit_provider.dart';
import '../widgets/configured_habit_tile.dart';
import '../widgets/habit_form_card.dart';

/// Screen for adding, viewing, and deleting configured habits.
class ConfigureHabitsScreen extends StatefulWidget {
  const ConfigureHabitsScreen({super.key});

  @override
  State<ConfigureHabitsScreen> createState() => _ConfigureHabitsScreenState();
}

class _ConfigureHabitsScreenState extends State<ConfigureHabitsScreen> {
  final _nameController = TextEditingController();
  Color _selectedColor = AppColors.habitPalette[0];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleAddHabit() {
    final provider = context.read<HabitProvider>();
    final error = provider.addHabit(_nameController.text, _selectedColor);

    if (error != null) {
      AppSnackbar.show(context, error, AppSnackbarType.error);
      return;
    }

    _nameController.clear();
    setState(() => _selectedColor = AppColors.habitPalette[0]);
    AppSnackbar.show(
      context,
      'Habit added successfully',
      AppSnackbarType.success,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> _confirmDelete(String habitId, String habitName) async {
    await AppDialogs.showConfirm(
      context,
      title: 'Delete Habit',
      message: 'Are you sure you want to delete "$habitName"?',
      confirmLabel: 'Delete',
      confirmColor: AppColors.error,
      onConfirm: () {
        context.read<HabitProvider>().deleteHabit(habitId);
        AppSnackbar.show(
          context,
          'Habit deleted',
          AppSnackbarType.error,
          duration: const Duration(seconds: 1),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final habits = context.watch<HabitProvider>().habits;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        title: const Text(
          'Configure Habits',
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
              HabitFormCard(
                controller: _nameController,
                selectedColor: _selectedColor,
                onColorSelected: (color) =>
                    setState(() => _selectedColor = color),
                onAdd: _handleAddHabit,
              ),
              const SizedBox(height: AppSizes.spacing24),
              const Text(
                'Your Habits',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.spacing12),
              if (habits.isEmpty)
                const AppEmptyState(
                  message: 'No habits yet. Add your first one above!',
                  compact: true,
                )
              else
                ...habits.map(
                  (habit) => ConfiguredHabitTile(
                    habit: habit,
                    onDelete: () => _confirmDelete(habit.id, habit.name),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
