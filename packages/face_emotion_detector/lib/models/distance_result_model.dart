import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../utils/enums.dart';

class FaceDistanceResult {
  final FaceDetectionStatus status;
  final double distanceCm;
  final String message;
  final Face? face;
  final double? faceWidthPixels;
  final double? imageWidth;

  FaceDistanceResult({
    required this.status,
    required this.distanceCm,
    required this.message,
    this.face,
    this.faceWidthPixels,
    this.imageWidth,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status.toString(),
      'distanceCm': distanceCm,
      'message': message,
      'faceWidthPixels': faceWidthPixels,
      'imageWidth': imageWidth,
    };
  }

  @override
  String toString() {
    return 'FaceDistanceResult{status: $status, distanceCm: $distanceCm, message: $message, faceWidthPixels: $faceWidthPixels, imageWidth: $imageWidth}';
  }
}
