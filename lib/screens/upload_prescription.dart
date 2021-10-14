import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:med_easey/widgets/common/bottomnavbar.dart';
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
  var imageBytes= Uint8List(0);

  set isUp(bool val) => setState(() => isUploaded = val);
  set img(bytes) => setState(() => imageBytes = bytes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: const Color(0xFFE5E5EE),
          appBar: const BasicAppbar(),
          bottomNavigationBar: const BottomNavBar(1),
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topLeft,
                    colors:[
                      Color(0xFF12EFDB),
                      Color(0xFF32B4DC),
                    ],
                  ),
                ),
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
                              color: Colors.black54,
                            ))),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: const Text(
                            'Please Upload a Valid Prescription from your doctor.', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ))

                    ),
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
                  const SizedBox(height: 10),
                  imageBytes.lengthInBytes != 0 ?
                  Image.memory(imageBytes, width: 200, height: 200,) : const SizedBox(),
                ],) : Container()
            ],
          )
    );
  }
}
