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
      FirebaseUser _firebaseUser = await AuthService().signInWithGoogle();

      if (_firebaseUser != null) {
        User user = User(
          uuid: Uuid().v4(),
          name: _firebaseUser.displayName,
          email: _firebaseUser.email,
          photoUrl: _firebaseUser.photoUrl,
        );

        saveUser(user);
        return user;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  void saveUser(User _user) {
    _prefs.setString('user', json.encode(_user));
    print('${_user.name} saved');
  }

  User getUser() {
    try {
      return User.fromJson(json.decode(_prefs.getString('user')));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      _prefs.remove('user');
    } catch (error) {
      print(error);
    }
  }
}
