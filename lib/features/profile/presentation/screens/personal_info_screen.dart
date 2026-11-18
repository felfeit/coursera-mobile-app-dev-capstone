import 'package:coursera_mobile_app_dev_capstone/features/auth/presentation/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../widgets/profile_country_dropdown.dart';
import '../widgets/profile_form_field.dart';

/// Screen for viewing and updating personal account information.
class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late double _age;
  late String _country;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _usernameController = TextEditingController(text: user?.username ?? '');
    _age = (user?.age ?? 25).toDouble();
    _country = AppStrings.countries.contains(user?.country)
        ? user!.country
        : AppStrings.countries.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    final error = await provider.updateProfile(
      name: _nameController.text,
      username: _usernameController.text,
      age: _age.round(),
      country: _country,
    );

    if (!mounted) return;

    if (error != null) {
      AppSnackbar.show(context, error, AppSnackbarType.error);
      return;
    }

    AppSnackbar.show(
      context,
      'Profile updated successfully',
      AppSnackbarType.success,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;
    final countryProvider = context.watch<CountryProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        title: const Text(
          'Personal Info',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.spacing20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileFormField(
                  label: 'Name',
                  hint: 'Enter your name',
                  controller: _nameController,
                  validator: (value) => Validators.validateRequired(
                    value,
                    message: 'Name cannot be empty',
                  ),
                ),
                const SizedBox(height: AppSizes.spacing20),
                ProfileFormField(
                  label: 'Username',
                  hint: 'Enter your username',
                  controller: _usernameController,
                  validator: (value) => Validators.validateUsername(
                    value,
                    requiredMessage: 'Username cannot be empty',
                  ),
                ),
                const SizedBox(height: AppSizes.spacing20),
                Center(
                  child: Text(
                    'Age: ${_age.round()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Slider(
                  value: _age,
                  min: 10,
                  max: 100,
                  divisions: 90,
                  activeColor: AppColors.primary,
                  onChanged: (value) => setState(() => _age = value),
                ),
                const SizedBox(height: AppSizes.spacing12),
                const Text(
                  AppStrings.countryHint,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSizes.spacing8),
                ProfileCountryDropdown(
                  value: _country,
                  countries: countryProvider.countries,
                  isLoading: countryProvider.isLoading,
                  error: countryProvider.error,
                  onChanged: (value) => setState(() => _country = value),
                ),
                const SizedBox(height: AppSizes.spacing32),
                CustomButton(
                  label: 'Save Changes',
                  onPressed: _handleSave,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
