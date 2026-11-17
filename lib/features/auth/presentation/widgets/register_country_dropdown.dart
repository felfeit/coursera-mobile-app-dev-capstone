import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Country selector used by the registration form.
class RegisterCountryDropdown extends StatelessWidget {
  final String value;
  final List<String> countries;
  final ValueChanged<String> onChanged;

  const RegisterCountryDropdown({
    super.key,
    required this.value,
    required this.countries,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radius30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.textSecondary,
            ),
            items: countries
                .map(
                  (country) =>
                      DropdownMenuItem(value: country, child: Text(country)),
                )
                .toList(),
            onChanged: (country) {
              if (country != null) onChanged(country);
            },
          ),
        ),
      ),
    );
  }
}
