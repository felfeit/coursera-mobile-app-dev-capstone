import 'package:coursera_mobile_app_dev_capstone/features/auth/presentation/country_provider.dart';
import 'package:coursera_mobile_app_dev_capstone/features/notifications/presentation/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/presentation/auth_provider.dart';
import 'features/habits/presentation/habit_provider.dart';
import 'routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CountryProvider()..fetchCountries(),
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()..init()),
        ChangeNotifierProvider(create: (_) => HabitProvider()..init()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()..init()),
      ],
      child: const HabittApp(),
    ),
  );
}

class HabittApp extends StatefulWidget {
  const HabittApp({super.key});

  @override
  State<HabittApp> createState() => _HabittAppState();
}

class _HabittAppState extends State<HabittApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.create(context.read<AuthProvider>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Habitt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}
