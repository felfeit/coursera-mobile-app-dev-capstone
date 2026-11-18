import 'package:coursera_mobile_app_dev_capstone/features/auth/domain/model/country_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Country dropdown styled for the profile form.
/// Supports loading, error, and empty states.
class ProfileCountryDropdown extends StatelessWidget {
  final String value;
  final List<CountryModel> countries;
  final bool isLoading;
  final String? error;
  final ValueChanged<String> onChanged;

  const ProfileCountryDropdown({
    super.key,
    required this.value,
    required this.countries,
    required this.onChanged,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildContainer(
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.spacing12),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: AppSizes.spacing12),
              Text('Loading countries...'),
            ],
          ),
        ),
      );
    }

    if (error != null) {
      return _buildContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.spacing12),
          child: Text(
            'Failed to load countries',
            style: TextStyle(color: AppColors.error),
          ),
        ),
      );
    }

    final safeValue = countries.any((c) => c.name == value)
        ? value
        : (countries.isNotEmpty ? countries.first.name : value);

    return _buildContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: safeValue,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: countries
              .map(
                (country) => DropdownMenuItem(
                  value: country.name,
                  child: Row(
                    children: [
                      Image.network(
                        country.flagUrl,
                        width: 24,
                        height: 16,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const SizedBox(
                          width: 24,
                          height: 16,
                          child: Icon(Icons.flag, size: 14),
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacing12),
                      Expanded(child: Text(country.name)),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (country) {
            if (country != null) onChanged(country);
          },
        ),
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return DecoratedBox(
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
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing16),
        child: child,
      ),
    );
  }
}
