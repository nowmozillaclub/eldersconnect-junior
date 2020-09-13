import 'package:ec_junior/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User _mainUser;
  User _seniorUser;

  /// Getter for main user.
  User get user => _mainUser;

  /// Getter for senior user.
  User get senior => _seniorUser;

  /// Setup main user and senior user in the memory.
  Future<User> setupUser() async {
    // Get logged in user and convert it to User object.
    _mainUser =
        await this._convertToUser(await this._firebaseAuth.currentUser());

    // Fetch the senior user.
    _seniorUser = await this.seniorDetails;

    notifyListeners();
    return _mainUser;
  }

  /// Update timetableId for senior and junior users.
  Future<void> updateTimetableId(String timetableId) async {
    // Updating the junior record in cloud firestore.
    await this
        ._firestore
        .collection("juniors")
        .document(_mainUser.uid)
        .updateData({
      "timetableId": timetableId,
    });

    // Updating the senior record in cloud firestore.
    await this
        ._firestore
        .collection("seniors")
        .document(_seniorUser.uid)
        .updateData({
      "timetableId": timetableId,
    });

    // Update the in-memory reference of both main and senior user.
    this.setupUser();
    notifyListeners();
  }

  /// Convert the firebaseUser to the User object.
  Future<User> _convertToUser(FirebaseUser firebaseUser) async {
    if (firebaseUser != null) {
      String id = firebaseUser.uid;

      // Getting the junior record from the cloud firestore.
      final DocumentSnapshot userDocSnap =
          await this._firestore.collection("juniors").document(id).get();

      if (userDocSnap.exists) {
        return new User(
          photoUrl: userDocSnap.data["photoUrl"],
          phone: userDocSnap.data["phone"],
          email: userDocSnap.data["email"],
          connectedToUid: userDocSnap.data["connectedToUid"],
          connectedToName: userDocSnap.data["connectedToName"],
          name: userDocSnap.data["name"],
          uid: userDocSnap.data["uid"],
          timetableId: userDocSnap.data["timetableId"],
        );
      } else {
        return new User(
          photoUrl: firebaseUser.photoUrl,
          phone: firebaseUser.phoneNumber,
          email: firebaseUser.email,
          connectedToUid: null,
          connectedToName: null,
          name: firebaseUser.displayName,
          uid: firebaseUser.uid,
          timetableId: null,
        );
      }
    } else {
      return null;
    }
  }

  /// Google log in for users using Firebase.
  Future<void> signInWithGoogle() async {
    try {
      // Get the account trying to sign in using google.
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();

      // Authenticate the user using google.
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Use the authenticated credentials
      // and use them to log them into firestore.
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(authCredential);

      // Setup main user and senior user.
      await this.setupUser();

      // Update the firestore collection
      // if user has logged in for the first time.
      await this
          ._firestore
          .collection('juniors')
          .document(user.uid)
          .setData(user.toJson());
      notifyListeners();
    } catch (error) {
      print('Error: $error');
    }
  }

  /// Sign out the user.
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      notifyListeners();
    } catch (error) {
      print('Error: $error');
    }
  }

  /// Get the senior details from the cloud firestore.
  Future<User> get seniorDetails async {
    User juniorUser = this.user;

    // Getting the senior record from firestore.
    DocumentSnapshot seniorDocSnap = await this
        ._firestore
        .collection('seniors')
        .document(juniorUser.connectedToUid)
        .get();
    try {
      if (seniorDocSnap.exists) {
        // Returning the senior user object.
        return new User(
          uid: seniorDocSnap.data["uid"],
          name: seniorDocSnap.data["name"],
          connectedToName: seniorDocSnap.data["connectedToName"],
          connectedToUid: seniorDocSnap.data["connectedToUid"],
          email: seniorDocSnap.data['email'],
          phone: seniorDocSnap.data['phone'],
          photoUrl: seniorDocSnap.data['photoUrl'],
        );
      } else {
        return null;
      }
    } catch (error) {
      print(error);
    }
    return user;
  }
}
