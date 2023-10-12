import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("user_violations");

  FirebaseService() {
    // Initialize Firebase in the constructor
    Firebase.initializeApp();
  }

  Future<void> saveSelectedViolations(List<String> selectedViolations) async {
    try {
      var newChildRef = databaseReference.push();
      await newChildRef.set(selectedViolations);
    } catch (e) {
      print("Error saving data: $e");
    }
  }
}
