import 'package:flutter/material.dart';
import '../firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class ViolationApp extends StatelessWidget {
  const ViolationApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Violations',
      home: Violation(),
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

  final FirebaseService firebaseService = FirebaseService();

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
            // User is authenticated, proceed with saving data to the database.
            List<String> selected = [];
            for (int i = 0; i < violations.length; i++) {
              if (selectedViolations[i]) {
                selected.add(violations[i]);
              }
            }
            print("Selected Violations: $selected");

            // Save selected violations to Firebase using FirebaseService
            await firebaseService.saveSelectedViolations(selected);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Selected violations saved to Firebase.'),
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
