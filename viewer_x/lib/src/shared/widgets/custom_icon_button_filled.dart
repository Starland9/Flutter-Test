import 'package:flutter/material.dart';
import 'package:viewer_x/src/core/themes/colors/app_colors.dart';

class CustomIconButtonFilled extends StatelessWidget {
  const CustomIconButtonFilled({
    super.key,
    this.onPressed,
    required this.icon,
    this.size,
  });
  final VoidCallback? onPressed;
  final Widget icon;

  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.onPrimary,
        fixedSize: size == null ? null : Size.square(size!),
      ),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
