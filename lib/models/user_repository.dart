import 'dart:convert';

import 'package:ec_junior/models/user.dart';
import 'package:ec_junior/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  SharedPreferences _prefs;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<User> signInWithGoogle() async {
    try {
      AuthService _authService = AuthService();
      FirebaseUser _firebaseUser = await _authService.signInWithGoogle();

      if (_firebaseUser != null) {
        User user = User(
          uuid: Uuid().v4(),
          name: _firebaseUser.displayName,
          email: _firebaseUser.email,
          photoUrl: _firebaseUser.photoUrl,
        );

        _prefs.setString('user', json.encode(user));

        return user;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> isSignedIn() async {
    final String _user = _prefs.getString('user');
    return _user != null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
