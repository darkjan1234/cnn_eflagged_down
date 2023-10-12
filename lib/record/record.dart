// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordsScreen extends StatefulWidget {
  static var length;

  const RecordsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecordsScreenState createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  String plateNumber = "";
  String firstName = "";
  String lastName = "";
  String bodyType = "";
  String color = "";
  String dateRegistered = "";
  String dateExpiration = "";
  String chassisNo = "";
  String yearModel = "";
  String brand = "";

  void onplateNumberChanged(String value) {
    setState(() {
      plateNumber = value;
    });
  }

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

  void onbodyTypeChanged(String value) {
    setState(() {
      bodyType = value;
    });
  }

  void oncolorChanged(String value) {
    setState(() {
      color = value;
    });
  }

  void ondateRegisteredChanged(String value) {
    setState(() {
      dateRegistered = value;
    });
  }

  void ondateExpirationChanged(String value) {
    setState(() {
      dateExpiration = value;
    });
  }

  void onchassisNoChanged(String value) {
    setState(() {
      chassisNo = value;
    });
  }

  void onyearModelChanged(String value) {
    setState(() {
      yearModel = value;
    });
  }

  void onbrandChanged(String value) {
    setState(() {
      brand = value;
    });
  }

  // void onEditButtonPressed() {
  // Implement your Edit functionality here
  //   print("Edited: $name, $unit, $ticket, $impound, $plateNumber");
  // }

  void onSaveButtonPressed() async {
    try {
      print(
          "Saved: $plateNumber, $firstName, $lastName, $bodyType, $color, $dateRegistered, $dateExpiration, $yearModel, $brand ");

      // Get a reference to the Firestore collection
      CollectionReference details =
          FirebaseFirestore.instance.collection("details");

      // Create a new document with a generated ID
      await details.add({
        "plateNumber": plateNumber,
        "firstName": firstName,
        "lastName": lastName,
        "bodyType": bodyType,
        "color": color,
        "dateRegistered": dateRegistered,
        "dateExpiration": dateExpiration,
        "chassisNo": chassisNo,
        "yearModel": yearModel,
        "brand": brand,
      });

      // Clear the input fields after saving
      setState(() {
        plateNumber = "";
        firstName = "";
        lastName = "";
        bodyType = "";
        color = "";
        dateRegistered = "";
        dateExpiration = "";
        chassisNo = "";
        yearModel = "";
        brand = "";
      });

      print(
          "Saved: $plateNumber, $firstName, $lastName, $bodyType, $color, $dateRegistered, $dateExpiration, $yearModel, $brand");
    } catch (e) {
      print("Error saving data: $e");
    }
  }

  void onEditButtonPressed() {
    // Implement your Edit functionality here
    print(
        "Deleted: $plateNumber, $firstName, $lastName, $bodyType, $color, $dateRegistered, $dateExpiration, $yearModel, $brand");
  }

  void onDeleteButtonPressed() {
    // Implement your Edit functionality here
    print(
        "Deleted: $plateNumber, $firstName, $lastName, $bodyType, $color, $dateRegistered, $dateExpiration, $yearModel, $brand");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlateNo. Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AnimatedInputField(
              labelText: "plateNumber",
              onChanged: onplateNumberChanged,
            ),
            AnimatedInputField(
              labelText: "firstName",
              onChanged: onfirstNameChanged,
            ),
            AnimatedInputField(
              labelText: "lastName",
              onChanged: onlastNameChanged,
            ),
            AnimatedInputField(
              labelText: "bodyType",
              onChanged: onbodyTypeChanged,
            ),
            AnimatedInputField(
              labelText: "Color",
              onChanged: oncolorChanged,
            ),
            AnimatedInputField(
              labelText: "dateRegsitered",
              onChanged: ondateRegisteredChanged,
            ),
            AnimatedInputField(
              labelText: "dateExpiration",
              onChanged: ondateExpirationChanged,
            ),
            AnimatedInputField(
              labelText: "chassisNo",
              onChanged: onchassisNoChanged,
            ),
            AnimatedInputField(
              labelText: "yearModel",
              onChanged: onyearModelChanged,
            ),
            AnimatedInputField(
              labelText: "Brand",
              onChanged: onbrandChanged,
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
