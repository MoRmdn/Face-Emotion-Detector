import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDistanceCalculator {
  final double averageFaceWidthCm;
  final double sensorWidthMm;
  final double focalLengthMm;
  final FaceDetector _faceDetector;

  FaceDistanceCalculator({
    this.averageFaceWidthCm = 14.0,
    this.sensorWidthMm = 4.54,
    this.focalLengthMm = 3.5,
  }) : _faceDetector = FaceDetector(
          options: FaceDetectorOptions(
            enableLandmarks: true,
            performanceMode: FaceDetectorMode.accurate,
          ),
        );

  Future<FaceDistanceResult> calculateDistance(File imageFile) async {
    try {
      // Create InputImage from file
      final inputImage = InputImage.fromFile(imageFile);

      // Process image with face detector
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        return FaceDistanceResult(
          status: FaceDetectionStatus.noFaceDetected,
          distanceCm: 0,
          message: "No face detected",
        );
      }

      // Get image dimensions
      final image = await decodeImageFromList(await imageFile.readAsBytes());
      final imageWidth = image.width.toDouble();

      // Get face width from the first detected face
      final face = faces[0];
      final faceWidthPixels = face.boundingBox.width;

      // Calculate distance
      final distanceCm = _calculateDistanceInCm(faceWidthPixels, imageWidth);

      // Generate status message
      final status = _getDistanceStatus(distanceCm);
      final message = _generateMessage(distanceCm, status);

      return FaceDistanceResult(
        status: status,
        distanceCm: distanceCm,
        message: message,
        face: face,
        faceWidthPixels: faceWidthPixels,
        imageWidth: imageWidth,
      );
    } catch (e) {
      return FaceDistanceResult(
        status: FaceDetectionStatus.error,
        distanceCm: 0,
        message: "Error processing image: $e",
      );
    }
  }

  double _calculateDistanceInCm(double faceWidthPixels, double imageWidth) {
    // Convert measurements to cm
    final focalLengthCm = focalLengthMm / 10;
    final sensorWidthCm = sensorWidthMm / 10;

    // Calculate distance using the formula:
    // Distance = (Actual width × Focal length × Image width) / (Object width in pixels × Sensor width)
    double distance = (averageFaceWidthCm * focalLengthCm * imageWidth) /
        (faceWidthPixels * sensorWidthCm);

    // Round to one decimal place
    return double.parse(distance.toStringAsFixed(1));
  }

  FaceDetectionStatus _getDistanceStatus(double distanceCm) {
    if (distanceCm < 30) {
      return FaceDetectionStatus.tooClose;
    } else if (distanceCm > 100) {
      return FaceDetectionStatus.tooFar;
    }
    return FaceDetectionStatus.goodDistance;
  }

  String _generateMessage(double distanceCm, FaceDetectionStatus status) {
    String baseMessage = "$distanceCm cm";

    switch (status) {
      case FaceDetectionStatus.tooClose:
        return "$baseMessage - Too close! Please move back";
      case FaceDetectionStatus.tooFar:
        return "$baseMessage - Too far! Please move closer";
      case FaceDetectionStatus.goodDistance:
        return "$baseMessage - Good distance!";
      default:
        return baseMessage;
    }
  }

  void dispose() {
    _faceDetector.close();
  }
}




