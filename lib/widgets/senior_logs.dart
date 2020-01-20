import 'package:flutter/material.dart';

class SeniorLogs extends StatelessWidget {
  final Map<String, Map<String, String>> seniorlogs;

  SeniorLogs({Key key, this.seniorlogs}) : super(key: key);

  Widget buildLogs(BuildContext context, int index) {
    String key = this.seniorlogs.keys.elementAt(index);
    Map<String, String> dayLog = this.seniorlogs[key];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$key',
          style: TextStyle(fontSize: 16.0),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: dayLog.length,
          itemBuilder: (BuildContext context, int index) {
            String timeKey = dayLog.keys.elementAt(index);
            String log = dayLog[timeKey];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Text('$timeKey'),
                  Text(':'),
                  Text('$log'),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Senior Logs',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.amber),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: this.seniorlogs.length,
                itemBuilder: buildLogs),
          ],
        ),
      ),
    );
  }
}
