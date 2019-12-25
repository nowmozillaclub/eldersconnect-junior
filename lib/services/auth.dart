import 'package:ec_junior/services/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<FirebaseUser> get firebaseUser  {
    return _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn
          .signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final FirebaseUser user = await _auth.signInWithCredential(credential);

      await FirebaseDatabase(uid: user.uid, emailId: user.email).initialSaveToDatabase();

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
