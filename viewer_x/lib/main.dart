import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/src/app.dart';
import 'package:viewer_x/src/logic/services/cam_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await CamService.instance.init();

  runApp(ViewerXApp());
}
