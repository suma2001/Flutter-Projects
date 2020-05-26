import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/choose.dart';
import 'package:tictactoe/theme/theme.dart';
import 'package:tictactoe/pages/btn.dart';
import 'package:tictactoe/pages/logo.dart';

class StartPage extends StatelessWidget {
//final boardService = locator<BoardService>();

//StartPage({Key key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.65],
            colors: [
              MyTheme.orange,
              MyTheme.red,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Tic Tac",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 65,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DancingScript'),
                  ),
                  Logo(),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                    Btn(
//                      onTap: () {
//                        boardService.gameMode$.add(GameMode.Solo);
//                        soundService.playSound('click');
//
//                        Navigator.push(
//                          context,
//                          CupertinoPageRoute(
//                            builder: (context) => PickPage(),
//                          ),
//                        );
//                      },
//                      height: 40,
//                      width: 250,
//                      borderRadius: 250,
//                      color: Colors.white,
//                      child: Text(
//                        "single player".toUpperCase(),
//                        style: TextStyle(
//                            color: Colors.black.withOpacity(.8),
//                            fontSize: 16,
//                            fontWeight: FontWeight.w700),
//                      ),
//                    ),
                  SizedBox(height: 30),
                  Btn(
                    onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ChoosePage(),
                          ),
                        );
                    },
                    color: Colors.white,
                    height: 40,
                    width: 250,
                    borderRadius: 250,
                    child: Text(
                      "Play".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
