import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CameraApp extends StatelessWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CameraPage(
        title: 'Camera CNN',
      ),
    );
  }
}

Future<void> requestCameraPermission() async {
  final PermissionStatus status = await Permission.camera.request();

  if (status.isGranted) {
    // Permission granted, you can now proceed with camera-related code.
  } else {
    // Permission denied. Handle the case where the user denies camera access.
  }
}

late List<CameraDescription> cameras;

// Firebase Firestore setup
final firestoreInstance = FirebaseFirestore.instance;

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  dynamic controller;
  bool isBusy = false;
  dynamic textRecognizer;
  late Size size;

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async {
    // Request camera permission before initializing the camera.
    await requestCameraPermission();

    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      controller = CameraController(cameras[0], ResolutionPreset.max);
      await controller.initialize();
      if (mounted) {
        controller.startImageStream((image) {
          if (mounted && !isBusy) {
            isBusy = true;
            doTextRecognitionOnFrame(image);
          }
        });
      }
    } catch (e) {
      // Handle camera initialization errors.
      print("Error initializing camera: $e");
      // You might want to set controller to null here or handle the error appropriately.
    }
  }

  dynamic _scanResults;
  doTextRecognitionOnFrame(CameraImage image) async {
    if (controller == null || !controller.value.isInitialized) {
      // Handle the case when the controller is not initialized.
      return;
    }

    var frameImg = getInputImage(image);
    RecognizedText recognizedText = await textRecognizer.processImage(frameImg);
    print(recognizedText.text);

    // Use regular expressions to extract the desired format (3 letters and 4 numbers)
    RegExp regex = RegExp(r'[A-Z]{3}\s\d{4}');
    String? extractedText = regex.stringMatch(recognizedText.text);

    if (extractedText != null) {
      print("Extracted Text: $extractedText");

      // Save the recognized text to Firebase Firestore
      await firestoreInstance.collection('recognized_text').add({
        'text': extractedText,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    setState(() {
      _scanResults = recognizedText;
      isBusy = false;
    });
  }

  InputImage getInputImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final camera = cameras[0];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation!,
      inputImageFormat: inputImageFormat!,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    return inputImage;
  }

  Widget buildResult() {
    if (_scanResults == null ||
        controller == null ||
        !controller.value.isInitialized) {
      return const Text('');
    }

    final Size imageSize = Size(
      controller.value.previewSize!.height,
      controller.value.previewSize!.width,
    );
    CustomPainter painter = TextRecognitionPainter(imageSize, _scanResults);
    return CustomPaint(
      painter: painter,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    size = MediaQuery.of(context).size;
    if (controller != null) {
      stackChildren.add(
        Positioned(
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height,
          child: Container(
            child: (controller.value.isInitialized)
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  )
                : Container(),
          ),
        ),
      );

      stackChildren.add(
        Positioned(
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height,
          child: buildResult(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: stackChildren,
      ),
    );
  }
}

class TextRecognitionPainter extends CustomPainter {
  TextRecognitionPainter(this.absoluteImageSize, this.recognizedText);

  final Size absoluteImageSize;
  final RecognizedText recognizedText;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.brown;

    for (TextBlock block in recognizedText.blocks) {
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      canvas.drawRect(
        Rect.fromLTRB(
          block.boundingBox.left * scaleX,
          block.boundingBox.top * scaleY,
          block.boundingBox.right * scaleX,
          block.boundingBox.bottom * scaleY,
        ),
        paint,
      );

      TextSpan span = TextSpan(
        text: block.text,
        style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 54, 255, 35)),
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(
          block.boundingBox.left * scaleX,
          block.boundingBox.top * scaleY,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(TextRecognitionPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.recognizedText != recognizedText;
  }
}