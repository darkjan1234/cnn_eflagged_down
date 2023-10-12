import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:realtime_text_recognition/data/data.dart';
import 'package:realtime_text_recognition/homescreen.dart';
import 'package:flutter/material.dart';
import 'record/record.dart';
import 'violation/violation.dart';
import 'cameracnn/cameracnn.dart';
import 'data/data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/record/record': (context) => const RecordsScreen(),
        '/violation/violation': (context) => const Violation(),
        '/cameracnn/cameracnn': (context) => const CameraApp(),
        '/data/data': (context) => Data(),
      },
    );
  }
}

//Recordscreen Child Folder

//Camera Child Folder

// Violation Child Folder

//This is The Main App Bar


// Listile itmeans  this is the navbar

