import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_easey/utils/popup.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import '../../screens/upload_prescription.dart';

class UploadButton extends StatefulWidget {
  final String title;
  final IconData icon;

  const UploadButton({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  Future addToCart(String text) async {
    List lines = text.split("\n");
    List l = [];
    int count = 0;
    final String response =
        await rootBundle.loadString('assets/data/FinalData.json');
    final data = await json.decode(response);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    for (var i = 0; i < data.length; i++) {
      if (!l.contains(data[i]['Brand Name'])) {
        l.add(data[i]['Brand Name']);
      }
    }
    for (var j = 0; j < lines.length; j++) {
      for (var k = 0; k < l.length; k++) {
        if (StringSimilarity.compareTwoStrings(
                lines[j].toLowerCase(), l[k].toLowerCase()) >
            0.5) {
          if (preferences.getInt(l[k]) == null) {
            await preferences.setInt(l[k], 1);
            count++;
            break;
          }
        }
      }
    }
    popUp('$count items from your prescription added to cart');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          String imageText = '';
          final ImagePicker _picker = ImagePicker();
          XFile? image;
          if (widget.title == 'Gallery') {
            image = await _picker.pickImage(source: ImageSource.gallery);
          } else if (widget.title == 'Camera') {
            image = await _picker.pickImage(source: ImageSource.camera);
          } else {
            var filePickerResult = await FilePicker.platform.pickFiles();
            if (filePickerResult != null) {
              var _pdfDoc =
                  await PDFDoc.fromPath(filePickerResult.files.single.path!);
              String pdfText = await _pdfDoc.text;
              UploadPrescriptionScreen.of(context)!.isUp = true;
              UploadPrescriptionScreen.of(context)!.imageBytes = Uint8List(0);
              await addToCart(pdfText);
            }
          }
          if (widget.title != 'PDF') {
            final imgBytes = await image!.readAsBytes();
            final textDetector = GoogleMlKit.vision.textDetector();
            final inputImage = InputImage.fromFilePath(image.path);
            final RecognisedText recognisedText =
                await textDetector.processImage(inputImage);
            for (TextBlock block in recognisedText.blocks) {
              for (TextLine line in block.lines) {
                imageText += line.text + '\n';
              }
            }
            UploadPrescriptionScreen.of(context)!.isUp = true;
            UploadPrescriptionScreen.of(context)!.imageBytes = imgBytes;
            await addToCart(imageText);
          }
        },
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 20,
              child: Icon(
                widget.icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.title),
          ],
        ));
  }
}
