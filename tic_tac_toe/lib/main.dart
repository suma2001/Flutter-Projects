import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/start.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//  bool oTurn=true; // 1st player is O
//  List<String> displayXO = ['','','','','','','','',''];
//  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
//  int oscore=0;
//  int xscore=0;
//  int filledBoxes=0;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.grey[800],
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(30.0),
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Text('Player X', style: myTextStyle,),
//                        Text(xscore.toString(), style: myTextStyle,),
//                      ],
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(30.0),
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Text('Player O', style: myTextStyle,),
//                        Text(oscore.toString(), style: myTextStyle,),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 3,
//          child: GridView.builder(
//              itemCount: 9,
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//              itemBuilder: (BuildContext context, int index) {
//                return GestureDetector(
//                  onTap: () {
//                    _tapped(index);
//                  },
//                  child: Container(
//                    decoration: BoxDecoration(
//                      border: Border.all(color: Colors.grey[600])
//                    ),
//                    child: Center(
//                      child: Text(displayXO[index], style: TextStyle(color: Colors.white, fontSize: 40),),
//                    ),
//                  ),
//                );
//              }
//            ),
//          ),
//          Expanded(
//            child: Container(
//
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  void _tapped(int index) {
//
//    setState(() {
//      if(oTurn && displayXO[index]=='') {
//        displayXO[index] = 'O';
//        filledBoxes+=1;
//      }
//      else if (!oTurn && displayXO[index]=='') {
//        displayXO[index] = 'X';
//        filledBoxes+=1;
//      }
//      oTurn = !oTurn;
//      _checkWinner();
//    });
//  }
//
//  void _checkWinner() {
//
//    if(displayXO[0] == displayXO[1] && displayXO[1] == displayXO[2] && displayXO[0]!='') {
//      _showWinDialog(displayXO[0]);
//    }
//    if(displayXO[3] == displayXO[4] && displayXO[4] == displayXO[5] && displayXO[3]!='') {
//      _showWinDialog(displayXO[3]);
//    }
//    if(displayXO[6] == displayXO[7] && displayXO[7] == displayXO[8] && displayXO[6]!='') {
//      _showWinDialog(displayXO[6]);
//    }
//    if(displayXO[0] == displayXO[3] && displayXO[3] == displayXO[6] && displayXO[0]!='') {
//      _showWinDialog(displayXO[0]);
//    }
//    if(displayXO[1] == displayXO[4] && displayXO[4] == displayXO[7] && displayXO[1]!='') {
//      _showWinDialog(displayXO[1]);
//    }
//    if(displayXO[2] == displayXO[5] && displayXO[5] == displayXO[8] && displayXO[2]!='') {
//      _showWinDialog(displayXO[2]);
//    }
//    if(displayXO[0] == displayXO[4] && displayXO[4] == displayXO[8] && displayXO[0]!='') {
//      _showWinDialog(displayXO[0]);
//    }
//    if(displayXO[2] == displayXO[4] && displayXO[4] == displayXO[6] && displayXO[2]!='') {
//      _showWinDialog(displayXO[2]);
//    }
//
//    else if(filledBoxes==9) {
//      _showDrawDialog();
//    }
//
//  }
//
//  void _showDrawDialog() {
//    showDialog(
//        barrierDismissible: false,
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Text('DRAW'),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Play Again'),
//                onPressed: () {
//                  _clearBoard();
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        }
//    );
//  }
//
//  void _showWinDialog(String winner) {
//    showDialog(
//      barrierDismissible: false,
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('WINNER IS ' + winner),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Play Again'),
//              onPressed: () {
//                _clearBoard();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      }
//    );
//
//    if(winner == 'O') {
//      oscore+=1;
//    }
//    else if(winner == 'X') {
//      xscore+=1;
//    }
//  }
//
//  void _clearBoard() {
//    setState(() {
//      for(int i=0;i<9;i++) {
//        displayXO[i]='';
//      }
//    });
//  filledBoxes=0;
//  }
//}
