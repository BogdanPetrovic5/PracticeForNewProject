import 'package:firebase_database/firebase_database.dart';

Future<String?> getUsernameByUID(String uid) async {
  DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');

  try {
    DatabaseEvent event = await usersRef.child(uid).once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {

      Map<String, dynamic>? userData = _convertToMap(snapshot.value);

      if (userData != null) {
        String username = userData['username'] ?? '';
        print("USERNAME: ${username}");
        return username;
      } else {

        
        return null;
      }
    } else {
    
      
      return null;
    }
  } catch (error) {
   
    print('Error querying database: $error');
    return null;
  }
}
Map<String, dynamic>? _convertToMap(dynamic value) {
  // Explicitly convert 'value' to Map<String, dynamic> or return null
  if (value is Map<Object?, Object?>) {
    Map<String, dynamic> convertedMap = {};
    value.forEach((key, value) {
      if (key is String) {
        convertedMap[key] = value;
      }
    });
    return convertedMap;
  } else {
    return null;
  }
}
