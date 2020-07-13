import 'package:flutter/material.dart';
import 'package:weatherapp/Screens/forecast.dart';
import 'package:weatherapp/Screens/settings.dart';
import 'package:weatherapp/Screens/Feedback.dart';

class NavDrawer extends StatelessWidget {

  Settings s;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/download.jfif"),
                        fit: BoxFit.cover)),
                child: Text(""),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(children: [
              ListTile(
                leading: Icon(Icons.cloud),
                title: Text("5-day Forecast", style: TextStyle(fontSize: 16),),
                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder:(context)=>ForeCast()),
//                  );
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                      (BuildContext context) => new ForeCast()));
//                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings", style: TextStyle(fontSize: 16),),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                  (BuildContext context) => new Settings()));
//                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text("Feedback", style: TextStyle(fontSize: 16),),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                      (BuildContext context) => new feedback()));
//                  Navigator.pop(context);
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}