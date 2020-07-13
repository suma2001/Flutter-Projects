import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/Providers/TemperatureProvider.dart';
import 'package:weatherapp/Providers/WindSpeedProvider.dart';
import 'package:weatherapp/Providers/ToggleProvider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Widget appbar()
  {
      return AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new WeatherApp()));
            }),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      );
  }

  Widget Units()
  {
      return Wrap(
        children: <Widget>[
          Container(
              child: Text(
                "UNITS",
                style: TextStyle(color: Colors.grey[600], fontSize: 18),
              )),
          SizedBox(
            height: 20,
          ),
          Consumer<TemperatureProvider>(
              builder: (context, provider, child) {
                return Row(
                  children: <Widget>[
                    Container(
                        child: Text(
                          "Temperature Units",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )),
                    SizedBox(
                      width: 95,
                    ),
                    Container(
                      child: Text(
                        "\u00B0" + provider.tempSym,
                        style:
                        TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: new IconButton(
                          icon: new Icon(Icons.arrow_forward_ios),
                          iconSize: 20,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    child: new Wrap(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(20.0),
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Temperature Units",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          child: new ListTile(
                                            leading: new Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                            title:
                                            new Text("\u00B0" + "C"),
                                            onTap: () =>
                                            {provider.changeValue(0),
                                              Navigator.pop(context),},
                                          ),
                                        ),
                                        GestureDetector(
                                          child: new ListTile(
                                            leading: new Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                            title:
                                            new Text("\u00B0" + "F"),
                                            onTap: () =>
                                            {provider.changeValue(1),
                                              Navigator.pop(context),},
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 55.0,
                                              right: 55.0,
                                              bottom: 20.0,
                                              top: 30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                BorderRadius.circular(
                                                    25)),
                                            child: new ListTile(
                                              title: Center(
                                                  child:
                                                  new Text('Cancel')),
                                              onTap: () => {
                                                Navigator.pop(context),
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                    )
                  ],
                );
              }),
          SizedBox(
            height: 30,
          ),
          Consumer<WindSpeedProvider>(
              builder: (context, windprovider, child) {
                return Row(
                  children: <Widget>[
                    Container(
                        child: Text(
                          "Wind Speed Units",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )),
                    SizedBox(
                      width: 75,
                    ),
                    Container(
                      child: Text(
                        windprovider.windUnit.toString(),
                        style:
                        TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: new IconButton(
                          icon: new Icon(Icons.arrow_forward_ios),
                          iconSize: 20,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                    ),
                                    child: new Wrap(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(20.0),
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Wind Speed Units",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          child: new ListTile(
                                            leading: new Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                            title: new Text(
                                                "Kilometers per hour (km/h)"),
                                            onTap: () => {
                                              windprovider.changeWindUnit(0),
                                              Navigator.pop(context)
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          child: new ListTile(
                                            leading: new Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                            title: new Text(
                                                "Meters per second (m/s)"),
                                            onTap: () => {
                                              windprovider
                                                  .changeWindUnit(1),
                                              Navigator.pop(context)
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          child: new ListTile(
                                            leading: new Icon(
                                                Icons.arrow_forward_ios,
                                                size: 20),
                                            title: new Text(
                                                "Miles per hour (mph)"),
                                            onTap: () => {

                                              windprovider
                                                  .changeWindUnit(2),
                                              Navigator.pop(context),
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 55.0,
                                              right: 55.0,
                                              bottom: 20.0,
                                              top: 30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                BorderRadius.circular(
                                                    25)),
                                            child: new ListTile(
                                              title: Center(
                                                  child:
                                                  new Text('Cancel')),
                                              onTap: () => {
                                                Navigator.pop(context),
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                    )
                  ],
                );
              }),
        ],
      );
  }

  Widget OtherSettings()
  {
    return Wrap(
      children: <Widget>[
        Container(
            child: Text(
              "OTHER SETTINGS",
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            )),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Consumer<ToggleProvider>(
              builder: (context, toggleprovider, child) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                            child: Text(
                              "Dark Mode",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18),
                            )),
                        SizedBox(
                          width: 160,
                        ),
                        Container(
                          child: Switch(
                            value: toggleprovider.isSwitched1,
                            onChanged: (value) {
                              toggleprovider.swap1();
                            },
                            activeTrackColor: Colors.lightBlueAccent,
                            activeColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Text(
                              "Update at night automatically",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 17),
                            )),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          child: Switch(
                            value: toggleprovider.isSwitched2,
                            onChanged: (value) {
                              toggleprovider.swap2();
                            },
                            activeTrackColor: Colors.lightBlueAccent,
                            activeColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  Widget Policies()
  {
    return Wrap(
      children: <Widget>[
        Container(
            child: Text(
              "POLICIES",
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            )),
        SizedBox(
          height: 40,
        ),
        Row(
          children: <Widget>[
            Container(
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )),
            SizedBox(
              width: 180,
            ),
            Container(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(),
        backgroundColor: Colors.white,
        body: Container(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Units(),

                    SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 0.3,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    OtherSettings(),

                    SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 0.3,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Policies(),
                  ],
                ))));
  }
}
