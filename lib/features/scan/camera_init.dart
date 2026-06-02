import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

Future<void> initCamera() async {
  try {
    cameras = await availableCameras();
    print("✅ Caméras disponibles : ${cameras.length}");
  } catch (e) {
    print("❌ Erreur initialisation caméra : $e");
  }
}
