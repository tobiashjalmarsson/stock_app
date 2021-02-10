import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './API/market.dart';
import './API/stock.dart';
import './screens/graph_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Market market;
  @override
  void initState(){
    print("test");
    //market = Market();
    //market.populateMarket();
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
      initialRoute: '/',
      routes: {
        '/graphs' : (context) => GraphScreen(),
      },
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

  final String title;


  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double dailyChange = 1.24;
  double yearlyChange = 34.2;
  Market market = Market();
  List<Widget> stocks;


  List<Widget> getMarketList(Market market) {
    market.clearMarket();
    print(market.getStocks());
    market.populateMarket();
    List<Stock> currentStocks = market.getStocks();
    List<Widget> stockWidgets = [];
    stockWidgets.add(SizedBox(height: 10));
    stocks = [];
    for (Stock st in currentStocks){
      StockRow current = StockRow(company: st.name, dailyChange: st.dChange, yearlyChange: st.yChange);
      String currentName = st.name;
      stockWidgets.add(current);
      print("Stock added $currentName");
      stockWidgets.add(SizedBox(height: 10));
    }
    return stockWidgets;
  }

  @override

  Widget build(BuildContext context) {
    market.populateMarket();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
            Container(
              color: Colors.green,
              child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getMarketList(market),
                    ),
                  ),
              ),
        );
       // This trailing comma makes auto-formatting nicer for build methods.
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
    return GestureDetector(
      onTap: () {
        print("Clicked");
        Navigator.pushNamed(context, '/graphs');
      },
      child: Container(
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
      ),
    );
  }
}

