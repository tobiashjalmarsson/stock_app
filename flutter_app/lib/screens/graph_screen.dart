import 'package:flutter/material.dart';
class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Graphs route"),
            FloatingActionButton(
                onPressed: (){
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ),
    );
  }
}
