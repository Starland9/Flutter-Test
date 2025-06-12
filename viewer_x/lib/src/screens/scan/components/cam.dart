import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viewer_x/gen/assets.gen.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/shared/util/bank_card_util.dart';

class Cam extends StatelessWidget {
  const Cam({
    super.key,
    required this.context,
    required CameraController controller,
    this.imageFile,
    this.bankCard,
  }) : _controller = controller;

  final BuildContext context;
  final CameraController _controller;
  final XFile? imageFile;
  final BankCard? bankCard;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(3.0),
              width: double.maxFinite,
              height: 230.h,
              decoration: BoxDecoration(
                color: context.cs.secondary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: context.cs.onPrimary, width: 1.w),
              ),
              child: (!_controller.value.isInitialized)
                  ? Center(child: CircularProgressIndicator())
                  : imageFile != null
                  ? Image.file(File(imageFile!.path))
                  : CameraPreview(_controller),
            ),
            for (int i = 0; i < 4; i++)
              Positioned(
                top: i == 0 || i == 1 ? 0 : null,
                bottom: i == 2 || i == 3 ? 0 : null,
                left: i == 0 || i == 2 ? 0 : null,
                right: i == 1 || i == 3 ? 0 : null,
                child: RotatedBox(
                  quarterTurns: i == 2
                      ? 3
                      : i == 3
                      ? 2
                      : i,
                  child: Assets.icons.cameraCorner.svg(),
                ),
              ),
          ],
        ),
        if (bankCard != null)
          Container(
            margin: EdgeInsets.only(top: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: context.cs.secondary.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: context.cs.onPrimary, width: 1.w),
            ),
            child: Text(
              bankCard!.cardNumber,
              style: context.tt.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
