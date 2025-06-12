import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/gen/assets.gen.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/core/themes/colors/app_colors.dart';
import 'package:viewer_x/src/shared/widgets/custom_icon_button_filled.dart';

late List<CameraDescription> _cameras;

@RoutePage()
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   final CameraController? cameraController = controller;

//   // App state changed before we got the chance to initialize.
//   // App state changed before we got the chance to initialize.
//   // App state changed before we got the chance to initialize.
//   if (cameraController == null || !cameraController.value.isInitialized) {
//     return;
//   }

//   if (state == AppLifecycleState.inactive) {
//     cameraController.dispose();
//   } else if (state == AppLifecycleState.resumed) {
//     _initializeCameraController(cameraController.description);
//   }
// }

class _ScanScreenState extends State<ScanScreen> {
  late final CameraController? controller;

  @override
  void initState() {
    _initializeCameraController(null);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCameraController(
    CameraDescription? description,
  ) async {
    _cameras = await availableCameras();

    controller = CameraController(
      description ?? _cameras.first,
      ResolutionPreset.max,
    );
    try {
      await controller?.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          // Handle access errors here.
          break;
        default:
          // Handle other errors here.
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scanBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
          child: Column(
            spacing: 32.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExitIcon(context),
              _buildHeadTitle(context),
              _buildSubtitle(context),
              Spacer(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildActionButtons() {
    final size = 42;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30.w,
      children: [
        CustomIconButtonFilled(
          icon: Assets.icons.camera.svg(),
          onPressed: () {},
          size: size * 1.5,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: size.r,
          child: IconButton.filled(
            style: IconButton.styleFrom(
              fixedSize: Size.square((size * 1.9).r),
              backgroundColor: AppColors.scanBtn,
            ),
            onPressed: () {},
            icon: SizedBox(),
          ),
        ),
        CustomIconButtonFilled(
          icon: Assets.icons.camera.svg(),
          onPressed: () {},
          size: size * 1.5,
        ),
      ],
    );
  }

  Column _buildSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCam(),
        24.verticalSpace,
        Text(
          "Recto de la carte",
          style: context.tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        8.verticalSpace,
        SizedBox(
          width: 200.w,
          child: Text(
            "Positionner de manière précise les 04 coins de l'avant dans le cardre",
            textAlign: TextAlign.center,
            style: context.tt.bodySmall?.copyWith(fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Widget _buildCam() => Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: double.maxFinite,
          height: 223.h,
          decoration: BoxDecoration(
            color: context.cs.secondary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: context.cs.onPrimary, width: 1.w),
          ),
          child: controller?.value.isInitialized == false
              ? Center(child: CircularProgressIndicator())
              : CameraPreview(controller!),
        ),
      ),
      Positioned(top: 0, left: 0, child: Assets.icons.cameraCorner.svg()),
      Positioned(
        top: 0,
        right: 0,
        child: RotatedBox(
          quarterTurns: 1,
          child: Assets.icons.cameraCorner.svg(),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: RotatedBox(
          quarterTurns: 3,
          child: Assets.icons.cameraCorner.svg(),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: RotatedBox(
          quarterTurns: 2,
          child: Assets.icons.cameraCorner.svg(),
        ),
      ),
    ],
  );

  Column _buildHeadTitle(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Scannez votre carte bancaire",
          style: context.tt.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Scannez le recto de votre carte bancaire",
          style: context.tt.bodySmall?.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  CustomIconButtonFilled _buildExitIcon(BuildContext context) {
    return CustomIconButtonFilled(
      icon: Assets.icons.arrowBack.svg(),
      onPressed: () => context.pop(),
    );
  }
}
