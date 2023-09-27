

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? getUserId() {
  final User? user = _firebaseAuth.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    return null; // User is not authenticated or not available
  }
}
 Future<String?> getUserProfilePhotoUrl(String uid) async {
  try {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_$uid.jpg');
    final String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    return null; // Handle errors as needed
  }
}

  Future<String?> getUserName(String userId) async {
    try {
      final  userData = await _firestore.collection('users').doc(userId).get();
      return await userData.get('name') as String?;
    } catch (e) {
      print('Error fetching user name: $e');
      return null;
    }
  }
}

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerWithUserInfo({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        // Create a user document in Firestore with additional information
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          // Add other user information as needed
        });
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    }
  }

  Future<void> register({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    }
  }
 

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Private method to handle FirebaseAuthException
  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        throw WeakPasswordException();
      case 'email-already-in-use':
        throw EmailAlreadyInUseException();
      case 'user-not-found':
      case 'wrong-password':
        throw InvalidCredentialsException();
      default:
        throw AuthException(e.message ?? 'An error occurred during authentication.');
    }
  }
}


class WeakPasswordException implements Exception {
  final String message = 'The password provided is too weak.';
}

class EmailAlreadyInUseException implements Exception {
  final String message = 'The account already exists for that email.';
}

class InvalidCredentialsException implements Exception {
  final String message = 'Invalid email or password.';
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

// Create a separate class for Google Firebase authentication
class GoogleFirebaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    // Implement Google Firebase authentication logic here
    try {
      // Example: signInWithGoogle using Firebase Google Sign-In package
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      // // Additional logic after successful Google Firebase sign-in
    } catch (e) {
      throw Exception('Error during Google sign-in: ${e.toString()}');
    }
  }
}
