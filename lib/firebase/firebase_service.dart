import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("user_violations");

  FirebaseService() {
    // Initialize Firebase if it's not already initialized
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp();
    }
  }

  Future<void> saveSelectedViolations(List<String> selectedViolations) async {
    try {
      // Authenticate the user (optional, based on your requirements)
      // User? user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   // User is authenticated, proceed with saving data to the database.
      //   // ...
      // } else {
      //   // User is not authenticated; you may want to handle this case accordingly.
      //   // ...
      // }

      var newChildRef = databaseReference.push();
      await newChildRef.set(selectedViolations);
    } catch (e) {
      print("Error saving data: $e");
    }
  }
}
