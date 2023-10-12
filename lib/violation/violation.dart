import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ViolationApp extends StatelessWidget {
  const ViolationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize Firebase
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return MaterialApp(
      title: 'Violations',
      home: FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Violation();
          } else if (snapshot.hasError) {
            return const Text('Error Initializing Firebase');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Violation extends StatefulWidget {
  const Violation({Key? key}) : super(key: key);

  @override
  _ViolationState createState() => _ViolationState();
}

class _ViolationState extends State<Violation> {
  final List<String> violations = [
    "No Helmet",
    "No Driver License",
    "No OCR",
    "Driving with Sleepers",
    "No Headlight",
    "No Backlight",
    "No Side Mirror",
    "Backrider No Helmet",
    "Careless Driving",
    "Modified Muffler",
    "Excess Passenger",
    "Expired OR/CR",
    "Obstruction",
    // ... (other violations)
  ];

  List<bool> selectedViolations = List.filled(13, false);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Violations'),
      ),
      body: ListView.builder(
        itemCount: violations.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            title: Text(violations[index]),
            value: selectedViolations[index],
            onChanged: (bool? value) {
              setState(() {
                selectedViolations[index] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Authenticate the user
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // User is authenticated, proceed with saving data to Firestore.
            List<String> selected = [];
            for (int i = 0; i < violations.length; i++) {
              if (selectedViolations[i]) {
                selected.add(violations[i]);
              }
            }
            print("Selected Violations: $selected");

            // Save selected violations to Firestore
            await firestore.collection("violations").add({
              "selectedViolations": selected,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Selected violations saved to Firestore.'),
              ),
            );
          } else {
            // User is not authenticated; you may want to handle this case accordingly.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Authentication required to save data.'),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
