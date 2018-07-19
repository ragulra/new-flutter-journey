import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purpleAccent
      ),
      home: Login(),
    )
  );
}

class Login extends StatefulWidget {
  @override
    _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loggedIn = false;
  String _unameorem;
  String _password;

  final _formKey = GlobalKey<FormState>();
  final _mainKey = GlobalKey<ScaffoldState>();

  void onLogoutTap() {
    setState(() {
      loggedIn = false;
    });
  }

  void onRegisterTap() {
    var form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      setState(() {
        loggedIn = true;
      });

      var snackBar = SnackBar(
        content: Text('Data: username -> $_unameorem, password -> $_password'),
        duration: Duration(milliseconds: 1000),
      );

      _mainKey.currentState.showSnackBar(snackBar);
    }
  }

  Widget _cardWidget() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      elevation: 12.0,
      child: Container(
        height: 300.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'REGISTER',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24.0
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Username/Email'
                    ),
                    validator: (str) {
                      if (str.contains('@')) {
                        return !str.contains('.com') ? 'Not a Valid Email!' : null;
                      } else {
                        return str.length < 5 ? 'User Name At least 5 Char' : null;
                      }
                    },
                    onSaved: (str) {
                      return _unameorem = str;
                    },
                  ),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password'
                    ),
                    validator: (str) {
                      return str.length < 9 ? 'Password at Least 9 char' : null;
                    },
                    onSaved: (str) {
                      return _password = str;
                    },
                    obscureText: true,
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 12.0)),
                  GestureDetector(
                    onTap: () {
                      print('Forget Password Tapped');
                    },
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        color: Theme.of(context).disabledColor
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 12.0)),
                  RaisedButton(
                    onPressed: onRegisterTap,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        key: _mainKey,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/login_background.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    Container(color: Colors.purple.withOpacity(0.4), height: MediaQuery.of(context).size.height * 0.5)
                  ],
                ),
                Flexible(
                  child: Container(
                    color: Colors.white,
                  )
                )
              ],
            ),
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 150.0),
              children: <Widget>[
                !loggedIn ? _cardWidget() :
                Column(
                  children: <Widget>[
                    Text(
                      'Welcome $_unameorem',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0
                      ),
                    ),
                    RaisedButton(
                      onPressed: onLogoutTap,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor
                        ),
                      ),
                      highlightColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    }
}