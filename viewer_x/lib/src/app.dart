import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/src/core/routing/app_router.dart';
import 'package:viewer_x/src/core/themes/colors/app_colors.dart';

class ViewerXApp extends StatelessWidget {
  final _appRouter = AppRouter();

  ViewerXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'ViewerX',
          routerConfig: _appRouter.config(),
          builder: (context, appWidget) {
            return Theme(data: _buildTheme(), child: appWidget!);
          },
        );
      },
      child: this,
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
    scaffoldBackgroundColor: AppColors.onPrimary,
    textTheme: Typography.englishLike2018.apply(
      fontSizeFactor: 1.sp,
      bodyColor: AppColors.onSecondary,
      displayColor: AppColors.onSecondary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        fixedSize: Size(double.maxFinite, 55.h),
        textStyle: Typography.englishLike2018
            .apply(fontSizeFactor: 1.sp)
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
