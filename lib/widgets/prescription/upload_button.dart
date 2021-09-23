import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_text/pdf_text.dart';
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
              UploadPrescriptionScreen.of(context)!.text = pdfText;
              UploadPrescriptionScreen.of(context)!.isUp = true;
              UploadPrescriptionScreen.of(context)!.imageBytes = null;
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
            UploadPrescriptionScreen.of(context)!.text = imageText;
            UploadPrescriptionScreen.of(context)!.isUp = true;
            UploadPrescriptionScreen.of(context)!.imageBytes = imgBytes;
          }
        },
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 20,
              child: Icon(widget.icon,color: Colors.white, ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.title),
          ],
        ));
  }
}
