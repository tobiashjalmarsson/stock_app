import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/stock_screen.dart';
import 'package:http/http.dart' as http;
import './API/market.dart';
import './API/stock.dart';
import './screens/graph_screen.dart';
import './screens/login_screen.dart';
import './API/route_generator.dart';


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
      onGenerateRoute: RouteGenerator.generateRoute,
      /*
      routes: {
        '/' : (context) => MyHomePage(),
        '/graphs' : (context) => GraphScreen(),
        '/stocks' : (context) => StockScreen(),
      },

       */
      // Instead of a route map, adding a routing function to use dynamic data

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
      //home:  MyHomePage(title: 'Brrrrrr'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create controller for the text fields
  final String myPassword = "test123";
  final String myUsername = "tester";
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  // We need to clean up the controllers when the widget is disposed off.
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool checkInfo(String username, String password){
    if((password == myPassword) && (username == myUsername)){
      return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Welcome")),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Brrrrrr",
              style: TextStyle(
                fontSize: 35,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 20, top: 0, end: 20, bottom: 15),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 20, top: 0, end: 20, bottom: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Container(
              width: 175,
              child: FloatingActionButton(
                onPressed: () {
                  String username = usernameController.text;
                  String password = passwordController.text;
                  if(checkInfo(username, password)){
                    Navigator.pushNamed(context, '/stocks');
                  }
                  else {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("username: $username, password: $password"),
                          );
                        }
                    );
                  }

                },
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                child: Text(
                    "Login"
                ),

              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}