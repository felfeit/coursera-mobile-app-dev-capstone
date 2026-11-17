import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

/// Reusable empty-state presentation with optional compact layout.
class AppEmptyState extends StatelessWidget {
  final String message;
  final String? title;
  final IconData icon;
  final bool compact;
  final EdgeInsetsGeometry? compactPadding;
  final AlignmentGeometry compactAlignment;
  final TextAlign compactTextAlign;

  const AppEmptyState({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.compact = false,
    this.compactPadding,
    this.compactAlignment = Alignment.center,
    this.compactTextAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Padding(
        padding:
            compactPadding ??
            const EdgeInsets.symmetric(vertical: AppSizes.spacing24),
        child: Align(
          alignment: compactAlignment,
          child: Text(
            message,
            textAlign: compactTextAlign,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 100,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppSizes.spacing16),
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: AppColors.textPrimary),
            ),
          const SizedBox(height: AppSizes.spacing8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
