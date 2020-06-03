import 'package:ec_junior/utils/colors.dart';
import 'package:flutter/material.dart';

class SeniorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top) * 0.26,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.5),
                    Colors.purpleAccent.withOpacity(0.7),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.only(left: 6),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Details",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: 'OpenSans'),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            child: CircleAvatar(child: Icon(Icons.person),backgroundColor: Colors.black54,),
                            padding: EdgeInsets.all(7),
                          ),
                          Text(
                            " Parthav Joshi",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(7),child: CircleAvatar(child: Icon(Icons.favorite),backgroundColor: Colors.black54,)),
                          Text("Healthy/Unwell",style: TextStyle(fontFamily: 'OpenSans',fontSize: 18),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
