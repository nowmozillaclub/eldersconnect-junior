import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';

class SeniorLogs extends StatelessWidget {
  final Map<String, Map<String, String>> seniorlogs;

  SeniorLogs({Key key, this.seniorlogs}) : super(key: key);
  Widget buildLogs(BuildContext context, int index) {
    String key = this.seniorlogs.keys.elementAt(index);
    Map<String, String> eachDay = this.seniorlogs[key];
    return Column(
      children: <Widget>[
        Text(
          '$key',
          style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'OpenSans' ),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: eachDay.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var time = eachDay.keys.elementAt(index);
              var log = eachDay[time];
              return Row(
                children: <Widget>[
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    ": ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    log,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Senior",
                      style: Theme.of(context).textTheme.title,
                    )),
                Text(
                  "Logs",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'OpenSans'),
                ),
              ],
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: buildLogs,
              itemCount: this.seniorlogs.length,
            ),
          ],
        ),
      ),
    );
  }
}
