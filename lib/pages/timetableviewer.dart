

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TimeTableView extends StatefulWidget {
  static final String routeName = "/time-viewer";
  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  final _firestore= Firestore.instance;
  Future handleSearch(UserProvider userProvider) async{
    final currentuid= userProvider.user.timetableId;
    DocumentSnapshot docSnap=  await _firestore.collection('timetable').document(currentuid).get();
    print("yes");
    print(docSnap.data['timetable']);
    return docSnap;
  }
  @override
  Widget build(BuildContext context) {
    final usr= Provider.of<UserProvider>(context);
    return Scaffold(
      body: FutureBuilder(
          future: handleSearch(usr),
          builder: (context, snapshots){
            return ListView.builder(
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(snapshots.data['timetable'][index]['title'],),
                  leading: SizedBox(child: Text(snapshots.data['timetable'][index]['time']),),
                );
              },
              itemCount: snapshots.data['timetable'].length,
            );
          },
        ),

    );
  }
}
