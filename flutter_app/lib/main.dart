import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    print("test");
    super.initState();
    getStockData();
  }

  // This function should be moved to the networking_helper
  Future<void> getStockData() async{
    print("Starting fetch");
    var url = 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH&tsyms=USD';
    var response = await http.get(url);
    // Now decode the data
    var decodedResponse = jsonDecode(response.body);
    // Now split the data into BTC and ETC
    var btc = decodedResponse['BTC']['USD'];
    var eth = decodedResponse['ETH']['USD'];
    print("BTC: $btc, ETH: $eth");
    print("Fetch complete");

  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.teal,
        brightness: Brightness.light,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  MyHomePage(title: 'Brrrrrr'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double dailyChange = 1.24;
  double yearlyChange = 34.2;
  @override

  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Scaffold(
        body: Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StockRow(company: "Apple" ,dailyChange: dailyChange, yearlyChange: yearlyChange),
              SizedBox(
                height: 10,
              ),
              StockRow(company: "Google",dailyChange: 3.4, yearlyChange: 10.7),
              SizedBox(
                height: 10,
              ),
              StockRow(company: "Amazon",dailyChange: -1.4, yearlyChange: 10.7),
              SizedBox(
                height: 10,
              ),
              StockRow(company: "Bitcoin",dailyChange: -4.0, yearlyChange: -31.2),
              SizedBox(
                height: 10,
              ),
              StockRow(company: "Etherium",dailyChange: -3.2, yearlyChange: -40.1),
            ],
          ),
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class StockRow extends StatefulWidget {
  const StockRow({
    Key key,
    @required this.company,
    @required this.dailyChange,
    @required this.yearlyChange,
  }) : super(key: key);

  final String company;
  final double dailyChange;
  final double yearlyChange;



  @override
  _StockRowState createState() => _StockRowState();
}

class _StockRowState extends State<StockRow> {
  @override
  Widget build(BuildContext context) {
    Color getColor(double change){
        if(change < 0){
          return Colors.redAccent;
        }
        else {
          return Colors.green;
        }
    }
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.tealAccent,
            width: 1,
          )
        ),
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        height: 45,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget> [

              Text(
                "${widget.company}",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(
                width: 65,
              ),
              Text(
                "1d: ${widget.dailyChange}%",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: getColor(widget.dailyChange)
                ),
              ),

              Text(
                "12m: ${widget.yearlyChange}%",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: getColor(widget.yearlyChange)
                ),
              ),
            ]
        )
    );
  }
}
