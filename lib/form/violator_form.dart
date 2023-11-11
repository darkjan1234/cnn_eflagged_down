import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'receipt.dart';

class ViolationForm extends StatefulWidget {
  const ViolationForm({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<ViolationForm> {
  String firstName = "";
  String lastName = "";
  String address = "";
  String age = "";

  void onFirstNameChanged(String value) {
    setState(() {
      firstName = value;
    });
  }

  void onLastNameChanged(String value) {
    setState(() {
      lastName = value;
    });
  }

  void onAddressChanged(String value) {
    setState(() {
      address = value;
    });
  }

  void onAgeChanged(String value) {
    setState(() {
      age = value;
    });
  }

  void onSaveButtonPressed() async {
    try {
      print("Saved: $firstName, $lastName, $address, $age");

      // Get a reference to the Firestore collection
      CollectionReference form = FirebaseFirestore.instance.collection("form");

      // Create a new document with a generated ID
      DocumentReference result = await form.add({
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

      print("Saved: $firstName, $lastName, $address, $age");

      // Check if the document was successfully added to Firestore
      if (result.id != null) {
        // Navigate to ConfirmationPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmationPage()),
        );
      }
    } catch (e) {
      print("Error saving data: $e");
      // Handle the error, you might show an error message to the user
    }
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
              labelText: "First Name",
              onChanged: onFirstNameChanged,
            ),
            AnimatedInputField(
              labelText: "Last Name",
              onChanged: onLastNameChanged,
            ),
            AnimatedInputField(
              labelText: "Address",
              onChanged: onAddressChanged,
            ),
            AnimatedInputField(
              labelText: "Age",
              onChanged: onAgeChanged,
            ),
            SizedBox(height: 16.0), // Spacer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onSaveButtonPressed,
                  child: Text('Save'),
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
      {Key? key, required this.labelText, required this.onChanged});

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
        ),
      ),
    );
  }
}
