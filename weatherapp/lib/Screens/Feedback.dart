import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {

  final maxLines = 10;
  String _result = "Describe the issue you've encountered";
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = "Describe the issue you've encountered";
          break;
        case 1:
          _result = "Tell us how you would like to improv MIUI.";
          break;
      }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Feedback", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                      "Report bugs every time you encounter problems to help us solve them faster.",
                      style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  SizedBox(width: 25,),
                  new Radio(
                    value: 0,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Container(
                    child: Text("Issues", style: (TextStyle(fontSize: 16)),),
                  ),
                  SizedBox(width: 50,),
                  new Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Container(
                    child: Text("Sugestions", style: (TextStyle(fontSize: 16)),),
                  ),
                ],
              ),
              Container(
                height: maxLines * 24.0,
                child: TextField(
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: _result,
                  fillColor: Colors.grey[100],
                  filled: true,
                ),
              ),
              ),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Phone Number/Email",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val.length==0) {
                    return "Email cannot be empty";
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(child: Text("Send", style: TextStyle(color: Colors.white, fontSize: 22),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
