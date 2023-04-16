# Face Emotion Detector

This Flutter package allows you to detect emotions from facial expressions in an image. The package is designed to detect four types of emotions: "Very Happy", "Happy", "Neutral", and "Not Happy". 

## Installation

To use this package, add `face_emotion_detector` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  face_emotion_detector: ^1.0.0
``` 


Then, run the command:

```
$ flutter pub get
```
# Usage

## Import the package
First, import the package into your Dart file:
```
import 'package:face_emotion_detector/face_emotion_detector.dart';
```
## Create an instance of EmotionDetector
Then, create an instance of `EmotionDetector`:
```
final emotionDetector = EmotionDetector();
```
## Detect emotions from an image
To detect emotions from an image, use the detectEmotionFromImage() method and pass the image file:
```
final label = await emotionDetector.detectEmotionFromImage(image: file);
```
The detectEmotionFromImage() method returns a String with the detected emotion.

## Example
Here's an example of how to use the package:
```
import 'package:face_emotion_detector/face_emotion_detector.dart';
import 'dart:io';

void main() async {
  final emotionDetector = EmotionDetector();
  final file = File('path_to_image');
  final label = await emotionDetector.detectEmotionFromImage(image: file);
  print(label);
}
```

## Output
The detectEmotionFromImage() method returns a String with one of the following values:

* Very Happy
* Happy
* Neutral
* Not Happy

## Example
Here are some example images and the expected output:

![ezgif-3-c05365544a](https://user-images.githubusercontent.com/61588132/232283578-d8ff80c4-8676-4175-bbfd-9d9fa85a4dd7.gif)


## Contributing and Collaboration
`Contributions and collaboration are welcome!` If you're interested in contributing, please see our contributing guidelines for more details. If you're interested in collaborating on this package, please feel free to reach out to us via email at `talha.developer.01@gmail.com`. We welcome all contributions and feedback.

# License
This package is licensed under the MIT License.



