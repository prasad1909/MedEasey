import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widgets/common/appbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme())
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        String imageText = '';
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        final textDetector = GoogleMlKit.vision.textDetector();
                        final inputImage = InputImage.fromFilePath(image!.path);
                        final RecognisedText recognisedText =
                            await textDetector.processImage(inputImage);
                        for (TextBlock block in recognisedText.blocks) {
                          for (TextLine line in block.lines) {
                            for (TextElement element in line.elements) {
                              imageText += element.text + ' ';
                            }
                          }
                        }
                        setState(() {
                          text = imageText;
                        });
                      },
                      child: const Text('Process Image')),
                      Text(text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
