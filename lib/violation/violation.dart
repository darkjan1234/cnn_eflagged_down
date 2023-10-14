import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViolationApp extends StatelessWidget {
  const ViolationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Violations',
      home: const Violation(),
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
          // Collect selected violations
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
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
