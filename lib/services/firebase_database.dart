import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  final String uid;
  final String emailId;

  FirebaseDatabase({this.uid, this.emailId});

  Future<void> initialSaveToDatabase() async {
    try {
      final CollectionReference juniorCollectionReference =
          _firestore.collection('juniors');
      DocumentSnapshot juniorDocument =
          await juniorCollectionReference.document(this.uid).get();
      Map<String, dynamic> juniorMap = juniorDocument.data;

      if (juniorMap == null) {
        await juniorCollectionReference.document(this.uid).setData(
            {"uid": this.uid, "emailId": this.emailId, "connectedTo": ""});
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> connectToSeniorApp(String seniorUid) async {
    try {
      await _firestore.collection('seniors').document(seniorUid).updateData({
        "connectedTo": this.uid,
      });

      await _firestore.collection('juniors').document(this.uid).updateData({
        "connectedTo": seniorUid,
      });
    } catch (error) {
      print(error);
    }
  }
}
