import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Country dropdown styled for the profile form.
class ProfileCountryDropdown extends StatelessWidget {
  final String value;
  final List<String> countries;
  final ValueChanged<String> onChanged;

  const ProfileCountryDropdown({
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
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
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
