import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../auth/presentation/auth_provider.dart';

/// Navigation drawer for the home screen.
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.spacing20,
              AppSizes.spacing60,
              AppSizes.spacing20,
              AppSizes.spacing30,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(AppSizes.radius30),
              ),
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: AppColors.textOnPrimary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.format_list_bulleted,
            label: 'Habits',
            onTap: () {
              Navigator.pop(context);
              context.push('/habits/configure');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            label: 'Personal Info',
            onTap: () {
              Navigator.pop(context);
              context.push('/profile');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.bar_chart,
            label: 'Report',
            onTap: () {
              Navigator.pop(context);
              context.push('/report');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            onTap: () {
              Navigator.pop(context);
              context.push('/notifications');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            label: 'Sign Out',
            iconColor: AppColors.error,
            onTap: () async {
              Navigator.pop(context);
              await context.read<AuthProvider>().logout();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textPrimary),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
      ),
      onTap: onTap,
    );
  }
}
