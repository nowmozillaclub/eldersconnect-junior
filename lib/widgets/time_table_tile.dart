import 'package:flutter/material.dart';

class TimeTableTile extends StatelessWidget {
  final String time;
  final String task;
  final List<dynamic> day;

  TimeTableTile({this.day, this.task, this.time});

  @override
  Widget build(BuildContext context) {
    print(day);
   return Card(
     child: Row(
       children: <Widget>[
         Container(
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.purple,),
           height: 70,
           width: (MediaQuery.of(context).size.width - 16)/4,
           child: Center(child: Text(time, style: TextStyle(),)),
         ),
         Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             Text(task),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: day.map((title) {
                 return Text(title + " ,");
               }).toList(),
             ),
           ],
         ),
       ],
     ),
   );
//    Stack(
//      children: <Widget>[
//        Container(
//          height: MediaQuery.of(context).size.height*0.1,
//          margin: EdgeInsets.all(8),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(10),
//              border: Border.all(color: Colors.grey)
//          ),
//          width: double.infinity,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.all(15),
//                child: Container(
//                  height: MediaQuery.of(context).size.height*0.1,
//                  color: Colors.amber,
//                  child: Text(time),
//                ),
//              ),
//              Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Text(task),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: day.map((title) {
//                      return Text(title + " ,");
//                    }).toList(),
//                  ),
//                ],
//              ),
//              SizedBox(
//                width: MediaQuery.of(context).size.width * 0.14,
//              ),
//            ],
//          ),
//        ),
//      ],
//    );
  }
}

