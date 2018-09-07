import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final Map data;

  UserPage({@required this.data});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).padding.top,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.0, 1.0],
                  colors: [
                    Color(0xffc107a2),
                    Color(0xfffcf123),
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                ),
              ),
            ),
            CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  print('logout');
                },
              ),
              title: 'Home Page',
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                )
              ],
            ),
            SizedBox(height: 100.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Fullname: ',
                        style: TextStyle(
                          fontSize: 23.0,
                        )
                      ),
                      TextSpan(
                        text: widget.data['fullname'],
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800
                        )
                      )
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Username: ',
                        style: TextStyle(
                          fontSize: 23.0,
                        )
                      ),
                      TextSpan(
                        text: widget.data['username'],
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800
                        )
                      )
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Password: ',
                        style: TextStyle(
                          fontSize: 23.0,
                        )
                      ),
                      TextSpan(
                        text: widget.data['password'],
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800
                        )
                      )
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Level: ',
                          style: TextStyle(
                            fontSize: 23.0,
                          )),
                      TextSpan(
                          text: widget.data['level'],
                          style: TextStyle(
                              fontSize: 11.0, fontWeight: FontWeight.w800))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final Widget leading;
  final String title;
  final List<Widget> actions;

  CustomAppBar({@required this.title, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      alignment: Alignment.center,
      height: kToolbarHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 1.0],
          colors: [
            Color(0xffc107a2),
            Color(0xfffcf123),
          ],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
        ),
      ),
      child: actions == null
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                leading,
                Expanded(child: Container()),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0,
                  ),
                ),
                Expanded(child: Container()),
                Row(children: actions)
              ],
            ),
    );
  }
}
