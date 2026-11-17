import 'package:coursera_mobile_app_dev_capstone/features/auth/presentation/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../widgets/register_country_dropdown.dart';
import '../widgets/register_habit_selector.dart';

/// Registration form for new Habitt users.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  String _country = 'Australia';
  double _age = 25;
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  static const _availableHabits = [
    'Wake Up Early',
    'Workout',
    'Drink Water',
    'Meditate',
    'Read a Book',
    'Practice Gratitude',
  ];
  final Set<String> _selectedHabits = {};

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final error = await authProvider.register(
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
        age: _age.round(),
        country: _country,
        habits: _selectedHabits.toList(),
      );

      if (!mounted) return;

      if (error != null) {
        AppSnackbar.show(context, error, AppSnackbarType.error);
      } else {
        AppSnackbar.show(
          context,
          'Registration successful! Please log in.',
          AppSnackbarType.success,
        );
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing32,
            vertical: AppSizes.spacing24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textOnPrimary,
                      ),
                      onPressed: () => context.go('/login'),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.registerTitle,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacing48),
                  ],
                ),
                const SizedBox(height: AppSizes.spacing32),
                CustomTextField(
                  controller: _nameController,
                  hintText: AppStrings.nameHint,
                  validator: Validators.validateRequired,
                ),
                const SizedBox(height: AppSizes.spacing16),
                CustomTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  validator: Validators.validateUsername,
                ),
                const SizedBox(height: AppSizes.spacing16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  validator: Validators.validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: AppSizes.spacing24),
                Text(
                  '${AppStrings.ageLabel}: ${_age.round()}',
                  style: const TextStyle(
                    color: AppColors.textOnPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Slider(
                  value: _age,
                  min: 10,
                  max: 100,
                  divisions: 90,
                  activeColor: AppColors.primaryLight,
                  inactiveColor: AppColors.textOnPrimarySubtle,
                  onChanged: (value) => setState(() => _age = value),
                ),
                const SizedBox(height: AppSizes.spacing16),
                RegisterCountryDropdown(
                  value: _country,
                  countries: AppStrings.countries,
                  onChanged: (value) => setState(() => _country = value),
                ),
                const SizedBox(height: AppSizes.spacing24),
                RegisterHabitSelector(
                  habits: _availableHabits,
                  selectedHabits: _selectedHabits,
                  onSelectionChanged: (habit, selected) {
                    setState(() {
                      if (selected) {
                        _selectedHabits.add(habit);
                      } else {
                        _selectedHabits.remove(habit);
                      }
                    });
                  },
                ),
                const SizedBox(height: AppSizes.spacing40),
                CustomButton(
                  label: AppStrings.registerButton,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: AppSizes.spacing24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
