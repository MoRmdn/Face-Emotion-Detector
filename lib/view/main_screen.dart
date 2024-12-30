import 'dart:io';

import 'package:face_emotion_detector/face_emotion_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../generated/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool flag = false;
  late File file;
  final ImagePicker picker = ImagePicker();
  String? label = "Loading...";
  Map<String, dynamic>? emotion = {};
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: ()async{
        //     final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
        //     if (photo != null) {
        //        file = File(photo.path);
        //        final emotionDetector = EmotionDetector();
        //         label = await emotionDetector.detectEmotionFromImage(image: file);
        //         print(label);
        //        setState(() {
        //           flag=true;
        //         });
        //     }
        //   },
        //   child:const Icon(Icons.camera_alt),
        // ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Transform.scale(
                  scale: 3.2,
                  child: Image.asset(
                    Assets.imagesBlod,
                    scale: 3,
                    fit: BoxFit.cover,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Emotion Detector",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.08,
                        color: Colors.white),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: width * 0.04, horizontal: width * 0.04),
                    margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                    width: width * 0.7,
                    height: width * 1.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xff6C63FF)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: flag
                        ? Image.file(file)
                        : SvgPicture.asset(
                            Assets.imagesUpload,
                          ),
                  ),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  flag
                      ? Text(
                          label!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.w600),
                        )
                      : Container(),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  // ElevatedButton(onPressed: (){}, child:const Text("Insert Image"))
                  InkWell(
                    onTap: () async {
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (photo != null) {
                        file = File(photo.path);
                        final emotionDetector = EmotionDetector();
                        emotion = await emotionDetector.detectEmotionFromImage(
                          image: file,
                        );
                        debugPrint(label);
                        setState(() {
                          flag = true;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                      decoration: BoxDecoration(
                        color: const Color(0xff6C63FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: width * 0.04, horizontal: width * 0.04),
                      child: const Text(
                        "Insert Image",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
