import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/theme/theme.dart';
import 'package:tictactoe/pages/x.dart';
import 'package:tictactoe/pages/o.dart';
import 'package:tictactoe/pages/btn.dart';
import 'package:tictactoe/pages/start.dart';
import 'package:tictactoe/pages/games.dart';
import 'package:tictactoe/pages/value.dart';

class ChoosePage extends StatefulWidget {
  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {

  String chosenValue = 'X';

  void setPlayerValue(value) {
    setState(() {
      chosenValue = value;
    });
  }

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
//          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Pic Your Side",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => setPlayerValue('X'),
                      child: X(100, 20),
                    ),
                    Radio(
                      onChanged: (e) => setPlayerValue(e),
                      activeColor: MyTheme.orange,
                      value: 'X',
                      groupValue: chosenValue,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "First",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => setPlayerValue("O"),
                      child: O(100, MyTheme.green),
                    ),
                    Radio(
                      onChanged: (e) => setPlayerValue(e),
                      activeColor: MyTheme.orange,
                      value: 'O',
                      groupValue: chosenValue,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Second",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Btn(
              onTap: () {

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => GamePage(),
                  ),
                );
              },
              height: 40,
              width: 250,
              borderRadius: 200,
              gradient: [MyTheme.orange, MyTheme.red],
              child: Text(
                "continue".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
//            Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              IconButton(
//                onPressed: () {
//                Navigator.push(
//                  context,
//                  CupertinoPageRoute(
//                    builder: (context) => StartPage(),
//                  ),
//                );
//                },
//                icon: Icon(Icons.home),
//                iconSize: 30,
//                color: Colors.black87,
//              ),
//            ],
//          ),
          ],
        ),
      ),
    );
  }
}
