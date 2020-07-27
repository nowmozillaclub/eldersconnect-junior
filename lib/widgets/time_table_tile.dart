import 'package:ec_junior/models/models.dart';
import 'package:ec_junior/providers/providers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../models/time_table_item.dart';

import 'package:provider/provider.dart';

class TimeTableTile extends StatelessWidget {
//  final String time;
//  final String task;
//  final List<dynamic> day;
final TimetableItem item;
  Random random = new Random();
  TimeTableTile({this.item});
  var text = '';
  var days = {'1':'Monday', '2':'Tuesday', '3':"Wednesday", '4':'Thur', '5':'Fri', '6':'Sat', '7':'Sun'};

  @override
  Widget build(BuildContext context) {
    final timetableprovider= Provider.of<TimeTableProvider>(context);
    print("ekdoteenchaar");
    Color color=Color.fromRGBO(random.nextInt(200), random.nextInt(200), random.nextInt(200), 1);
    print(item.days);
   return Dismissible(
     onDismissed: (dir) {
       timetableprovider.deleteTimeTabelItem(item);
     },
     direction: DismissDirection.endToStart,
     key: ValueKey(item.title),
     background: Container(
       color: color,
       child: Icon(Icons.delete),
       alignment: Alignment.centerRight,
       padding: EdgeInsets.only(right: 10),
     ),
     child: Card(
       color: Colors.black,
       shape: RoundedRectangleBorder(side: BorderSide(color: color, width: 2,), borderRadius: BorderRadius.all(Radius.circular(15))),
       shadowColor: color,
       elevation: 35,
       child: Row(
         children: <Widget>[
           Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
               color: color,),
             height: 70,
             width: (MediaQuery.of(context).size.width - 16)/4,
             child: Center(child: Text(item.time, style: TextStyle(),)),
           ),
           Padding(
             padding: EdgeInsets.only(left: 15),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(item.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 5),
                   child:
                       Builder(
                         builder: (context) {
                           item.days.forEach((title) => text+=days[title]+', ');
                           return
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                             Flexible(child: Container(child: Text(text, overflow: TextOverflow.ellipsis,))),],);
                         },
                       ),
                   ),
               ],
             ),
           ),
         ],
       ),
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

