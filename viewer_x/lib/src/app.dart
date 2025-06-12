import 'package:flutter/material.dart';
import 'package:viewer_x/src/core/routing/app_router.dart';
import 'package:viewer_x/src/core/themes/colors/app_colors.dart';

class ViewerXApp extends StatelessWidget {
  final _appRouter = AppRouter();

  ViewerXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: _buildTheme(),
    );
  }

  ThemeData _buildTheme() => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
    ),
    brightness: Brightness.light,
    useMaterial3: true,
  );
}
