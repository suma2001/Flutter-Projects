import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tictactoe/pages/o.dart';
import 'package:tictactoe/pages/start.dart';
import 'package:tictactoe/pages/x.dart';
import 'package:tictactoe/theme/theme.dart';
import 'package:tictactoe/pages/choose.dart';

class GamePage extends StatefulWidget {
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {

  bool oTurn=true; // 1st player is O
  List<String> displayXO = ['','','','','','','','',''];
  var myTextStyle = TextStyle(color: Colors.black87, fontSize: 30);
  int oscore=0;
  int xscore=0;
  int filledBoxes=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontFamily: 'DancingScript',
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: MyTheme.orange,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Material(
                    elevation: 5,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    child: Center(
                        child: Text(
                          xscore.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              X(35, 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10),
                child: Text(
                  "Player",
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                ),
              )
            ],
          ),
          board(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                O(35, MyTheme.green),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Text(
                    "Player",
                    style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Material(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: Center(
                          child: Text(
                            oscore.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => StartPage(),
                    ),
                  );
                },
                icon: Icon(Icons.home),
                iconSize: 30,
                color: Colors.black87,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {

    setState(() {
      if(oTurn && displayXO[index]=='') {
        displayXO[index] = 'O';
        filledBoxes+=1;
      }
      else if (!oTurn && displayXO[index]=='') {
        displayXO[index] = 'X';
        filledBoxes+=1;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {

    if(displayXO[0] == displayXO[1] && displayXO[1] == displayXO[2] && displayXO[0]!='') {
      _showWinDialog(displayXO[0]);
    }
    if(displayXO[3] == displayXO[4] && displayXO[4] == displayXO[5] && displayXO[3]!='') {
      _showWinDialog(displayXO[3]);
    }
    if(displayXO[6] == displayXO[7] && displayXO[7] == displayXO[8] && displayXO[6]!='') {
      _showWinDialog(displayXO[6]);
    }
    if(displayXO[0] == displayXO[3] && displayXO[3] == displayXO[6] && displayXO[0]!='') {
      _showWinDialog(displayXO[0]);
    }
    if(displayXO[1] == displayXO[4] && displayXO[4] == displayXO[7] && displayXO[1]!='') {
      _showWinDialog(displayXO[1]);
    }
    if(displayXO[2] == displayXO[5] && displayXO[5] == displayXO[8] && displayXO[2]!='') {
      _showWinDialog(displayXO[2]);
    }
    if(displayXO[0] == displayXO[4] && displayXO[4] == displayXO[8] && displayXO[0]!='') {
      _showWinDialog(displayXO[0]);
    }
    if(displayXO[2] == displayXO[4] && displayXO[4] == displayXO[6] && displayXO[2]!='') {
      _showWinDialog(displayXO[2]);
    }

    else if(filledBoxes==9) {
      _showDrawDialog();
    }

  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10),
                ),
                child: Text('Play Again', style: TextStyle(fontSize: 15, color: Colors.white),),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: Center(child: Text('WINNER IS ' + winner, )),
            actions: <Widget>[
              RaisedButton(
                elevation: 4,
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10),
                ),
                child: Text('Play Again', style: TextStyle(fontSize: 15, color: Colors.white),),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );

    if(winner == 'O') {
      oscore+=1;
    }
    else if(winner == 'X') {
      xscore+=1;
    }
  }

  void _clearBoard() {
    setState(() {
      for(int i=0;i<9;i++) {
        displayXO[i]='';
      }
    });
    filledBoxes=0;
  }

  Widget _output(int index) {
    double height=80;
    double width=60;
    String item=displayXO[index];
    if(item=='') {
      return Container(
        height: height,
        width: width,
      );
    }
    else {
      return Container(
        height: height,
        width: width,
        child: Center(
          child:
          item == 'X' ? X(50, 13) : O(50, MyTheme.green),
        ),
      );
    }
  }

  Widget board() {
    return Container(
      child: Expanded(
        flex: 3,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _tapped(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Center(
//                      child: Text(displayXO[index], style: TextStyle(color: Colors.white, fontSize: 40),),
                    child: _output(index),
                  ),
                ),
              );
            }
        ),
      ),
    );

  }
}
