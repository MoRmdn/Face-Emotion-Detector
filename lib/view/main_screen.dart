import 'dart:io';
import 'package:face_emotion_detector/face_emotion_detector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool flag=false;
  late File file;
  final ImagePicker picker = ImagePicker();
  String? label="No Face";
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title:const Text('My Emotion'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
          if (photo != null) {
             file = File(photo.path);
             final emotionDetector = EmotionDetector();
              label = await emotionDetector.detectEmotionFromImage(image: file);
              print(label);
             setState(() {
                flag=true;
              });
          }
        },
        child:const Icon(Icons.camera_alt),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            flag?Container(
              child: Image.file(file,width: width * 0.9,height: width * 0.9,),
            ):Container(),
            Text(label!)
          ],
        ),
      ),
    );
  }
}
