import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import '../../widgets/mydrawer.dart';

class OcrPage extends HookWidget {
  static const routeName = "/ocr-home-page";
  Future pickImage(
      ValueNotifier<File> pickedImage, ValueNotifier<bool> isImageLoad,
      [ImageSource source]) async {
    var temp =
        await ImagePicker.pickImage(source: source ?? ImageSource.gallery);
    if (temp != null) {
      pickedImage.value = temp;
      isImageLoad.value = !isImageLoad.value;
    }
  }

  Future<void> readText(
    File pickedImage,
    TextEditingController resultTextEditingController,
    ValueNotifier<bool> isReading,
  ) async {
    isReading.value = true;
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    resultTextEditingController.text = readText.text;
    isReading.value = !isReading.value;
  }

  @override
  Widget build(BuildContext context) {
    final pickedImage = useState<File>();
    final isImageLoad = useState(false);
    final isReading = useState(false);

    final resultTextEditingController =
        useTextEditingController(text: "No text");

    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognizer'),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            if (isImageLoad.value)
              AspectRatio(
                aspectRatio: 1.1,
                child: Card(
                  child: Image.file(pickedImage.value),
                ),
              )
            else
              Container(),
            SizedBox(height: 20.0),
            ButtonBar(
              children: <Widget>[
                RaisedButton.icon(
                  color: Colors.pink,
                  onPressed: () async =>
                      await pickImage(pickedImage, isImageLoad),
                  icon: Icon(Icons.camera),
                  label: Text('Camera'),
                ),
                RaisedButton.icon(
                  color: Colors.blueAccent,
                  onPressed: () async => await pickImage(
                      pickedImage, isImageLoad, ImageSource.gallery),
                  icon: Icon(Icons.image),
                  label: Text('Gallery'),
                ),
              ],
            ),
            RaisedButton(
              color: Colors.deepPurple,
              onPressed: isImageLoad.value
                  ? () async => await readText(
                      pickedImage.value, resultTextEditingController, isReading)
                  : null,
              child: Text(
                'Read text from image',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (isReading.value) LinearProgressIndicator(),

            TextField(
              maxLines: null,
              decoration: InputDecoration(
                  labelText: 'Your Result',
                  border: OutlineInputBorder(gapPadding: 10)),
              controller: resultTextEditingController,
              keyboardType: TextInputType.multiline,
            ),

            // Container(
            //   child: FittedBox(
            //     child: TextField(
            //       decoration: InputDecoration(
            //           labelText: 'Your Result', border: InputBorder.none),
            //       controller: resultTextEditingController,
            //       keyboardType: TextInputType.text,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

// class OcrPage extends StatefulWidget {
//   static const routeName = "/ocr-home-page";

//   @override
//   _OcrPageState createState() => _OcrPageState();
// }

// class _OcrPageState extends State<OcrPage> {
//   File pickedImage;
//   bool isImageLoaded = false;
//   String extractText = "No text";

//   List<TextElement> retriveText;
//   Future pickImage() async {
//     var temp = await ImagePicker.pickImage(source: ImageSource.camera);

//     if (temp != null) {
//       setState(() {
//         pickedImage = temp;
//         isImageLoaded = true;
//       });
//     }
//   }

//   Future readText() async {
//     FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
//     TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
//     VisionText readText = await recognizeText.processImage(ourImage);

//     setState(() {
//       extractText = readText.text;
//     });
//     // for (TextBlock block in readText.blocks) {
//     //   // print(block.text);
//     //   for (TextLine line in block.lines) {
//     //     // print(line.text);
//     //     for (TextElement words in line.elements) {
//     //       // print(words.text);
//     //     }
//     //   }
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Title'),
//       ),
//       drawer: MyDrawer(),
//       body: Column(
//         children: <Widget>[
//           isImageLoaded
//               ? Center(
//                   child: Container(
//                   height: 200.0,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: FileImage(pickedImage), fit: BoxFit.cover),
//                   ),
//                 ))
//               : Container(),
//           SizedBox(height: 20.0),
//           Row(
//             children: <Widget>[
//               RaisedButton(
//                 onPressed: pickImage,
//                 child: Text('Pick an Image'),
//               ),
//               SizedBox(
//                 width: 10.0,
//               ),
//               RaisedButton(
//                 onPressed: isImageLoaded ? readText : null,
//                 child: Text('Read text from image'),
//               ),
//             ],
//           ),
//           Container(
//             child: FittedBox(
//               child: Text(extractText),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
