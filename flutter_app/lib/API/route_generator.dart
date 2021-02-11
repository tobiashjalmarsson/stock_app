import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/stock_screen.dart';
import '../screens/graph_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (context) => MyHomePage()); // No arguments yet
      case '/stocks':
        return MaterialPageRoute(builder: (context) => StockScreen()); // No arguments yet
      case '/graphs':
        // Validation of correct data type, so that stock name is in fact a string
        if (args is String) {
          return MaterialPageRoute(
            builder: (context) => GraphScreen(
              companyName: args,
            ),
          );
        }
        // Set defaualt cases if args is not strings or route is not found to an error route
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (contect) {
      return Scaffold(
        appBar: AppBar(
            title: Text("Error"),
        ),
        body: Center(child: Text("404 - Invalid Route")),
      );
    });
  }
}

