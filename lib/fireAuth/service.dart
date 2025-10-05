// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AuthService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<Map<String, dynamic>?> loginUser(String username, String password) async {
//     try {
//       username = username.trim();
//       password = password.trim();
//
//       final allUsers = await _firestore.collection('users').get();
//
//       for (var doc in allUsers.docs) {
//         final data = doc.data();
//         final storedUsername = (data['username'] ?? '').toString().trim();
//         final storedPassword = (data['password'] ?? '').toString().trim();
//
//         if (storedUsername.toLowerCase() == username.toLowerCase() &&
//             storedPassword.toLowerCase() == password.toLowerCase()) {
//           return data;
//         }
//       }
//       return null;
//     } catch (e) {
//       print("Error: $e");
//       return null;
//     }
//   }
// }
//
