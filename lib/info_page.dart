import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtime_text_recognition/violation/violation.dart';

class InfoPage extends StatefulWidget {
  final String recognizedText;

  InfoPage({required this.recognizedText, required Map<String, dynamic> data});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("details")
        .where("plateNumber", isEqualTo: widget.recognizedText)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot document = querySnapshot.docs.first;
      data = document.data() as Map<String, dynamic>;
      setState(() {
        // Data fetched, trigger a rebuild to display the information
      });
    } else {
      // No match found for the scanned license plate.
      // Handle this scenario, e.g., show an error message.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Recognized Text: ${widget.recognizedText}'),
          if (data != null) Text('First Name: ${data!['firstName']}'),
          if (data != null) Text('Last Name: ${data!['lastName']}'),
          if (data != null) Text('Brand: ${data!['brand']}'),
          if (data != null) Text('Color: ${data!['color']}'),
          if (data != null) Text('Chassis Number: ${data!['chassisNo']}'),
          if (data != null) Text('Date Expiration: ${data!['dateExpiration']}'),
          if (data != null) Text('Date Registered: ${data!['dateRegistered']}'),
          if (data != null) Text('Year Model: ${data!['yearModel']}'),
          if (data != null) Text('BodyType: ${data!['bodyType']}'),
          // Add more Text widgets to display other information
          const Spacer(), // To push the button to the bottom
          ElevatedButton(
            onPressed: () {
              // Add your next button functionality here

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Violation())
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
