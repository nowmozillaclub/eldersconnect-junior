import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:ec_junior/widgets/time_table_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTableView extends StatefulWidget {
  static final String routeName = "/time-viewer";

  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  final _firestore = Firestore.instance;

  Future<DocumentSnapshot> handleSearch(UserProvider userProvider) async {
    final currentuid = userProvider.user.timetableId;
    DocumentSnapshot docSnap =
        await _firestore.collection('timetable').document(currentuid).get();
    print("yes");
    print(docSnap.data['timetable']);
    return docSnap;
  }

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("TimeTable"),),
      body: FutureBuilder(
        future: handleSearch(usr),
        builder: (context, snapshots) {
          if (ConnectionState.waiting == snapshots.connectionState) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: TimeTableTile(
                    task: snapshots.data['timetable'][index]['title'],
                    time: snapshots.data['timetable'][index]['time'],
                    day: snapshots.data['timetable'][index]['days'],
                  ),
                );
//                  ListTile(
//                  title: Text(snapshots.data['timetable'][index]['title'],),
//                  leading: SizedBox(child: Text(snapshots.data['timetable'][index]['time']),),
//                );
              },
              itemCount: snapshots.data['timetable'].length,
            );
          }
        },
      ),
    );
  }
}
