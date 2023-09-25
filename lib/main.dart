import 'package:camera/camera.dart';
import 'package:eflagged_down/homescreen.dart';
import 'package:flutter/material.dart';
import 'record/record.dart';
import 'violation/violation.dart';
import 'cameracnn/cameracnn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      },
    );
  }
}

//Recordscreen Child Folder

//Camera Child Folder

// Violation Child Folder

//This is The Main App Bar


// Listile itmeans  this is the navbar

