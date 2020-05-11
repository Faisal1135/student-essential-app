import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import '../../widgets/mydrawer.dart';

class OcrPage extends StatefulWidget {
  static const routeName = "/ocr-home-page";

  @override
  _OcrPageState createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  File pickedImage;
  bool isImageLoaded = false;
  String extractText = "No text";

  List<TextElement> retriveText;
  Future pickImage() async {
    var temp = await ImagePicker.pickImage(source: ImageSource.camera);

    if (temp != null) {
      setState(() {
        pickedImage = temp;
        isImageLoaded = true;
      });
    }
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    setState(() {
      extractText = readText.text;
    });
    // for (TextBlock block in readText.blocks) {
    //   // print(block.text);
    //   for (TextLine line in block.lines) {
    //     // print(line.text);
    //     for (TextElement words in line.elements) {
    //       // print(words.text);
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          isImageLoaded
              ? Center(
                  child: Container(
                  height: 200.0,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(pickedImage), fit: BoxFit.cover),
                  ),
                ))
              : Container(),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: pickImage,
                child: Text('Pick an Image'),
              ),
              SizedBox(
                width: 10.0,
              ),
              RaisedButton(
                onPressed: isImageLoaded ? readText : null,
                child: Text('Read text from image'),
              ),
            ],
          ),
          Container(
            child: FittedBox(
              child: Text(extractText),
            ),
          )
        ],
      ),
    );
  }
}
