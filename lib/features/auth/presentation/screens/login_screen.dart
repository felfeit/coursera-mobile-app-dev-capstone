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

/// Sign-in form for existing Habitt users.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final error = await authProvider.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (error != null) {
        AppSnackbar.show(context, error, AppSnackbarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacing32,
              vertical: AppSizes.spacing24,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.appName,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing60),
                  CustomTextField(
                    controller: _usernameController,
                    hintText: AppStrings.usernameHint,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.text,
                    validator: Validators.validateUsername,
                  ),
                  const SizedBox(height: AppSizes.spacing16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: AppStrings.passwordHint,
                    prefixIcon: Icons.lock,
                    obscureText: _obscurePassword,
                    validator: Validators.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textOnPrimaryMuted,
                      ),
                      child: const Text(
                        AppStrings.forgotPassword,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  CustomButton(
                    label: AppStrings.loginTitle,
                    onPressed: _handleLogin,
                    isLoading: context.watch<AuthProvider>().isLoading,
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  const Text(
                    AppStrings.orText,
                    style: TextStyle(
                      color: AppColors.textOnPrimaryMuted,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  CustomButton(
                    label: AppStrings.signUp,
                    onPressed: () => context.go('/register'),
                    isOutlined: true,
                    backgroundColor: AppColors.surface,
                    textColor: AppColors.textOnPrimary,
                  ),
                  const SizedBox(height: AppSizes.spacing16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
