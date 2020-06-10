

import 'package:flutter/material.dart';
class Ask extends StatefulWidget {
  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> {
  @override
   Widget build(BuildContext context) { {
    return Scaffold(
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {_showDialog();
          // Add your onPressed code here!
        },
        label: Text('Ask'),
        icon: Icon(Icons.assignment_turned_in),
        backgroundColor: Colors.pink,
      
      ),
     
      body: ListView(
        
        children: <Widget>[
          // Padding(
            // padding: const EdgeInsets.all(8.0),

             new Container(
              
              decoration: BoxDecoration(
                color:Colors.purple.shade400,
                borderRadius: BorderRadius.only(
                  bottomRight:Radius.circular(42.0)
                ),
              ),
              
        height: 105,
        
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6.8,12.0,0.0,14.0),
          child:Row(
            children: <Widget>[
              Text(
                
                  "hello jagrit",
                  style: TextStyle(
                      fontFamily: 'fira',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade500,
                  ),

              ),
              
              new FlatButton(
              child:  Icon(Icons.close,color: Colors.blue),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
              
            ],
          ),
         
        ),
          
      ),
     
      SizedBox(height:40),
      new Container(
         child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.check,color: Colors.green),
              title: Text('Did you check your BP'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('again',
                  style: TextStyle(
                    color: Colors.red
                  )),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('change'
                ),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
      ),
      new Container(
         child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.close,color: Colors.red),
              title: Text('How is your Leg pain'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('again',
                  style: TextStyle(
                    color: Colors.red
                  )),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('change'
                ),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
      ),
      new Container(
         child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.history,color: Colors.green),
              title: Text('Did you had milk'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('again',
                  style: TextStyle(
                    color: Colors.red
                  )),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('change'
                ),
                  onPressed: () {/* ... */},
                ),
                
              ],
              
            ),
          ],
        ),
      ),
      ),
          //)
          
            
          
        ],
        
      
      )
      
    );
  }
}

void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
       
        return AlertDialog(
          title: new Text("Ask Your Question"),
          content:  new TextField(
                        decoration: new InputDecoration(hintText: "How is your knee pain"),
                        

                    ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Submit",style:TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}