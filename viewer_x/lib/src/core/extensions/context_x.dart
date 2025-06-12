import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextX on BuildContext {
  double get height => ScreenUtil().screenHeight;
  double get width => ScreenUtil().screenWidth;

  TextTheme get tt => Theme.of(this).textTheme;
  ColorScheme get cs => Theme.of(this).colorScheme;
}
