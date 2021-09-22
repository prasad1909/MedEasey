import 'package:flutter/material.dart';
import '../widgets/common/appbar.dart';
import '../widgets/prescription/upload_button.dart';

class UploadPrescriptionScreen extends StatefulWidget {
  const UploadPrescriptionScreen({Key? key}) : super(key: key);

  @override
  _UploadPrescriptionScreenState createState() =>
      _UploadPrescriptionScreenState();

  static _UploadPrescriptionScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_UploadPrescriptionScreenState>();
}

class _UploadPrescriptionScreenState extends State<UploadPrescriptionScreen> {
  bool isUploaded = false;
  String _text = '';
  var imageBytes;

  set text(String value) => setState(() => _text = value);
  set isUp(bool val) => setState(() => isUploaded = val);
  set img(bytes) => setState(() => imageBytes = bytes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: const BasicAppbar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  'Attach Prescription',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text('Upload',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF808080),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                          'Please Upload a Valid Prescription from your doctor')),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      UploadButton(icon: Icons.camera_alt, title: 'Camera'),
                      UploadButton(
                          icon: Icons.picture_in_picture_alt_rounded,
                          title: 'Gallery'),
                      UploadButton(icon: Icons.picture_as_pdf, title: 'PDF'),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            isUploaded ? Column (
              children: [
                Text(_text),
                const SizedBox(height: 10),
                imageBytes != null ? 
                Image.memory(imageBytes, width: 200, height: 200,) : const SizedBox(),
              ],) : Container()
          ],
        ));
  }
}
