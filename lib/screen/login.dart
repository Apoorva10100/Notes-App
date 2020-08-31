import 'package:flutter/material.dart';
import 'package:notes/screen/notes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: input() + buttons(context),
      ),
    );
  }
}

List<Widget> input() {
  return [
    Image(
      image: AssetImage('images/notes.png'),
    ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Email ID',
          icon: Icon(Icons.email, color: Color(0xfff2af29)),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Color(0xfff2af29),
          ),
        ),
      ),
    )
  ];
}

List<Widget> buttons(BuildContext context) {
  return [
    RaisedButton(
      color: const Color(0xfff2af29),
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontFamily: 'Arial',
          fontSize: 14,
          color: const Color(0xff000000),
        ),
        textAlign: TextAlign.left,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Notes(),
          ),
        );
      },
    ),
    FlatButton(
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 14,
            color: const Color(0xfff2af29),
          ),
          children: [
            TextSpan(
              text: 'Don\'t have an account? Sign Up!',
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(
                color: const Color(0xff000000),
              ),
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
      onPressed: null,
    ),
  ];
}
