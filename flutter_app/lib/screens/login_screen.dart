import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      Navigator.pushNamed(context, '/main');
                    }
                    else {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Wrong username or password"),
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
