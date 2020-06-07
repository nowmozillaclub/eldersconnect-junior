import 'package:ec_junior/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> get user async =>
      this._convertToUser(await this._firebaseAuth.currentUser());

  Future<User> _convertToUser(FirebaseUser firebaseUser) async {
    if (firebaseUser != null) {
      String id = firebaseUser.uid;

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
        );
      }
    } else {
      return null;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final AuthResult authResult =
      await _firebaseAuth.signInWithCredential(authCredential);

      final User user =
      await this._convertToUser(await this._firebaseAuth.currentUser());

      await this
          ._firestore
          .collection('juniors')
          .document(user.uid)
          .setData(user.toJson());

      notifyListeners();
    } catch (error) {
      // TODO: Implement Better Error Handling For Providers.
      print('Error: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      notifyListeners();
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<bool> isConnectedToSenior() async {
    User user = await this.user;

    if (user.connectedToUid == "" || user.connectedToUid == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<User> get seniorDetails async {
    User juniorUser = await this.user;

    DocumentSnapshot seniorDocSnap = await this._firestore
        .collection('seniors')
        .document(juniorUser.connectedToUid)
        .get();

    if(seniorDocSnap.exists) {
      return new User(
        uid: seniorDocSnap.data["uid"],
        name: seniorDocSnap.data["name"],
        connectedToName: seniorDocSnap.data["connectedToName"],
        connectedToUid: seniorDocSnap.data["connectedToUid"],
        email: seniorDocSnap.data['email'],
        phone: seniorDocSnap.data['phone'],
        photoUrl: seniorDocSnap.data['photoUrl'],
      );
    }

    return null;
  }
}
