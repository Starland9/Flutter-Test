import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viewer_x/gen/assets.gen.dart';
import 'package:viewer_x/src/core/extensions/context_x.dart';
import 'package:viewer_x/src/core/themes/colors/app_colors.dart';
import 'package:viewer_x/src/screens/scan/components/cam.dart';
import 'package:viewer_x/src/shared/util/bank_card_util.dart';
import 'package:viewer_x/src/shared/widgets/custom_icon_button_filled.dart';

@RoutePage()
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key, required this.cameraDescription});

  final CameraDescription cameraDescription;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  late final CameraController _controller = CameraController(
    widget.cameraDescription,
    ResolutionPreset.max,
  );

  bool _isImageProcessing = false;
  bool _isImageCapturing = false;
  XFile? _selectedImageFile;
  BankCard? _bankCard;

  @override
  void initState() {
    _initializeCameraController(null);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.isInitialized) {
      return;
    }
    final CameraController cameraController = _controller;

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  Future<void> _initializeCameraController(
    CameraDescription? description,
  ) async {
    try {
      await _controller.initialize();
      setState(() {});
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
        _buildFlashButton(size),
        _buildPictureTakerButton(size),
        _buildImagePickerButton(size),
      ],
    );
  }

  CircleAvatar _buildPictureTakerButton(int size) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: size.r,
      child: _isImageCapturing || _isImageProcessing
          ? CircularProgressIndicator.adaptive()
          : IconButton.filled(
              style: IconButton.styleFrom(
                fixedSize: Size.square((size * 1.9).r),
                backgroundColor: AppColors.scanBtn,
              ),
              onPressed: _takeAndAnalysePicture,
              icon: SizedBox(),
            ),
    );
  }

  Widget _buildImagePickerButton(int size) {
    if (_isImageProcessing) {
      return SizedBox();
    }

    return CustomIconButtonFilled(
      icon: Assets.icons.camera.svg(),
      onPressed: _takeAndAnalyseImageFile,
      size: size * 1.5,
    );
  }

  Widget _buildFlashButton(int size) {
    if (_isImageProcessing) {
      return SizedBox();
    }

    return CustomIconButtonFilled(
      icon: Icon(
        _controller.value.flashMode == FlashMode.off
            ? Icons.flash_off
            : Icons.flash_on,
        color: Colors.black,
      ),
      onPressed: () async {
        setState(() {
          _controller.setFlashMode(
            _controller.value.flashMode == FlashMode.off
                ? FlashMode.auto
                : FlashMode.off,
          );
        });
      },
      size: size * 1.5,
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

  Widget _buildCam() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: Cam(
      context: context,
      controller: _controller,
      imageFile: _selectedImageFile,
      bankCard: _bankCard,
    ),
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

  void _takeAndAnalysePicture() async {
    try {
      setState(() {
        _isImageCapturing = true;
      });
      final file = await _controller.takePicture();
      if (!mounted) return;
      if (file.path.isNotEmpty) {
        await analyseImage(file);
      }
      print(file);
    } on CameraException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    } finally {
      setState(() {
        _isImageCapturing = false;
      });
    }
  }

  void _takeAndAnalyseImageFile() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result != null) {
        await analyseImage(result);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> analyseImage(XFile imageFile) async {
    try {
      setState(() {
        _isImageProcessing = true;
        _selectedImageFile = imageFile;
      });

      final inputImage = InputImage.fromFilePath(imageFile.path);
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );

      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      setState(() {
        _bankCard = parseBankCard(recognizedText.text);
      });

      await textRecognizer.close();
    } on Exception catch (e) {
      print(e);
    } finally {
      setState(() {
        _isImageProcessing = false;
      });
    }
  }
}
