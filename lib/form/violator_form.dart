// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Form extends StatefulWidget {
  static var length;

  const Form ({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  String firstName = "";
  String lastName = "";
  String address = "";
  String age = "";

  void onfirstNameChanged(String value) {
    setState(() {
      firstName = value;
    });
  }

  void onlastNameChanged(String value) {
    setState(() {
      lastName = value;
    });
  }

  void onaddressChanged(String value) {
    setState(() {
      address = value;
    });
  }

  void onageChanged(String value) {
    setState(() {
      age = value;
    });
  }

  

  // void onEditButtonPressed() {
  // Implement your Edit functionality here
  //   print("Edited: $name, $unit, $ticket, $impound, $plateNumber");
  // }

  void onSaveButtonPressed() async {
    try {
      print(
          "Saved: $firstName, $lastName, $address, $age");

      // Get a reference to the Firestore collection
      CollectionReference form =
          FirebaseFirestore.instance.collection("form");

      // Create a new document with a generated ID
      await form.add({
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "age": age,
      });

      // Clear the input fields after saving
      setState(() {
        firstName = "";
        lastName = "";
        address = "";
        age = "";
      });

      print(
          "Saved: $firstName, $lastName, $address, $age");
    } catch (e) {
      print("Error saving data: $e");
    }
  }

  void onEditButtonPressed() {
    // Implement your Edit functionality here
    print(
        "Deleted: $firstName, $lastName, $address, $age");
  }

  void onDeleteButtonPressed() {
    // Implement your Edit functionality here
    print(
        "Deleted: $firstName, $lastName, $address, $age");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Violator Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AnimatedInputField(
              labelText: "firstName",
              onChanged: onfirstNameChanged,
            ),
            AnimatedInputField(
              labelText: "lastName",
              onChanged: onlastNameChanged,
            ),
            AnimatedInputField(
              labelText: "address",
              onChanged: onaddressChanged,
            ),AnimatedInputField(
              labelText: "age",
              onChanged: onageChanged,
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
