// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecordsScreenState createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  String name = "";
  String unit = "";
  String ticket = "";
  String impound = "";
  String plateNumber = "";

  void onNameChanged(String value) {
    setState(() {
      name = value;
    });
  }

  void onUnitChanged(String value) {
    setState(() {
      unit = value;
    });
  }

  void onTicketChanged(String value) {
    setState(() {
      ticket = value;
    });
  }

  void onImpoundChanged(String value) {
    setState(() {
      impound = value;
    });
  }

  void onPlateNumberChanged(String value) {
    setState(() {
      plateNumber = value;
    });
  }

  // void onEditButtonPressed() {
  // Implement your Edit functionality here
  //   print("Edited: $name, $unit, $ticket, $impound, $plateNumber");
  // }

  void onSaveButtonPressed() async {
    try {
      print("Saved: $name, $unit, $ticket, $impound, $plateNumber");

      // Get a reference to the Firestore collection
      CollectionReference drivers =
          FirebaseFirestore.instance.collection("drivers");

      // Create a new document with a generated ID
      await drivers.add({
        "driverName": name,
        "unitCycle": unit,
        "ticketNumber": ticket,
        "imPound": impound,
        "plateNumber": plateNumber,
      });

      // Clear the input fields after saving
      setState(() {
        name = "";
        unit = "";
        ticket = "";
        impound = "";
        plateNumber = "";
      });

      print("$name Saved");
    } catch (e) {
      print("Error saving data: $e");
    }
  }

  void onEditButtonPressed() {
    // Implement your Edit functionality here
    print("Deleted: $name, $unit, $ticket, $impound, $plateNumber");
  }

  void onDeleteButtonPressed() {
    // Implement your Edit functionality here
    print("Deleted: $name, $unit, $ticket, $impound, $plateNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AnimatedInputField(
              labelText: "Name",
              onChanged: onNameChanged,
            ),
            AnimatedInputField(
              labelText: "Unit",
              onChanged: onUnitChanged,
            ),
            AnimatedInputField(
              labelText: "Ticket",
              onChanged: onTicketChanged,
            ),
            AnimatedInputField(
              labelText: "Impound",
              onChanged: onImpoundChanged,
            ),
            AnimatedInputField(
              labelText: "Plate Number",
              onChanged: onPlateNumberChanged,
            ),
            SizedBox(height: 16.0), // Spacer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onSaveButtonPressed,
                  child: Text('Save'),
                ),
                SizedBox(width: 16.0), // Spacing between buttons
                ElevatedButton(
                  onPressed: onEditButtonPressed,
                  child: Text('Edit'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: onDeleteButtonPressed,
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedInputField extends StatefulWidget {
  final String labelText;
  final Function(String) onChanged;

  const AnimatedInputField(
      {super.key, required this.labelText, required this.onChanged});

  @override
  _AnimatedInputFieldState createState() => _AnimatedInputFieldState();
}

class _AnimatedInputFieldState extends State<AnimatedInputField> {
  TextEditingController _controller = TextEditingController();
  bool _isFocused = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onChanged(_controller.text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        onHover: (isHovered) {
          setState(() {
            _isHovered = isHovered;
          });
        },
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isHovered ? Colors.blue : Colors.grey,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
          onChanged: (String name) {},
          onEditingComplete: () {
            setState(() {
              _isFocused = false;
            });
          },
        ),
      ),
    );
  }
}
