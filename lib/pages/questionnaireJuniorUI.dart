
// import 'package:chips_choice/chips_choice.dart';

// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ask extends StatefulWidget {
  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> {
   final myController = TextEditingController();
   final detailController = TextEditingController(text: '');
  String _val;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
 
   Widget build(BuildContext context) { {
    return Scaffold(
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showDialog();
          
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
                  onPressed: () {repeatQues();
                                    },
                                  ),
                                  FlatButton(
                                    child: const Text('change'
                                  ),
                                    onPressed: () {
                                      updateQues();
                                                                          },
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
                                                                  
                                                                  content:  new TextField(controller: myController,
                                                                                decoration: new InputDecoration(hintText: "How is your knee pain"),  
                                                                            ),
                                                                  actions: <Widget>[
                                                                    // usually buttons at the bottom of the dialog
                                                                    new FlatButton(
                                                                      child: new Text("Submit",style:TextStyle(color: Colors.green)),
                                                                      onPressed: () {
                                                                       
                                                                         ask_Ques( myController.text);
                                                        
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }
                                                        }
                                      
                                       updateQues() {
                                        print("updating");
}
                  
                   repeatQues() {
                     print("again");
}

 // saving the responses onto firebase
    Future<void> junior_ques() async {
    
      await Firestore.instance.collection("res").add({
        'response': true,        
      });
      }

       Future<void> ask_Ques(contents) async {
            await Firestore.instance.collection("res").add({
               '$contents': false,       
                   });
            }