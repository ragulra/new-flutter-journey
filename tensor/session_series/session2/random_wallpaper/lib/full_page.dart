import 'package:flutter/material.dart';

class FullPage extends StatefulWidget {
  final String imageUrl;

  FullPage({@required this.imageUrl});

  @override
  _FullPageState createState() => _FullPageState();
}

class _FullPageState extends State<FullPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            widget.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              CustomAppBar(
                title: 'Full Page',
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;

  CustomAppBar({@required this.title});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      color: Colors.transparent,
      width: double.infinity,
      height: kToolbarHeight,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 25.0),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: Theme.of(context).textTheme.title.fontSize,
            ),
          )
        ],
      ),
    );
  }
}
