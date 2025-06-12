import 'package:camera/camera.dart';

class CamService {
  CamService._();

  static final instance = CamService._();

  List<CameraDescription> cameras = [];

  Future<void> init() async {
    cameras = await availableCameras();
  }
}
