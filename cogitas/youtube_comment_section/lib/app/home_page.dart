import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List data;

  HomePage({@required this.data});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '10 Reason why flutter is masterpiece',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      FlutterLogo()
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {},
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            icon: Icon(Icons.view_list),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.replay),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('0:001'),
                          ),
                          Expanded(child: Container()),
                          Row(
                            children: <Widget>[
                              Text('10:01'),
                              SizedBox(width: 8.0),
                              IconButton(
                                icon: Icon(Icons.fullscreen),
                                onPressed: () {},
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[YoutubeCommentItem(data: widget.data)], // before it pass to YoutubeCommentItem class you need to make a future function to turn the data into a class
            ),
          )
        ],
      ),
    );
  }
}

class YoutubeCommentItem extends StatelessWidget {
  final List<Comment> data; //turn into a class first

  YoutubeCommentItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                child: Text('0'), //should be random color
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'username' + ' * ' + '4 days ago',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'dfkjasdfsdfsdddddddddddddddddddddddddddddddddrrrrrrrrrrrd',
                      style: TextStyle(
                        fontSize: 13.0
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            SizedBox(width: 5.0),
                            Text('23')
                          ],
                        ),
                        SizedBox(width: 25.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.thumb_down),
                            SizedBox(width: 5.0),
                            Text('132')
                          ],
                        ),
                        SizedBox(width: 25.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.comment),
                            SizedBox(width: 5.0),
                            Text('232')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Show Replays',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

class Comment {
  final int id;
  final int postId;
  final String name;
  final String comment;
  final String email;

  Comment({this.id, this.postId, this.name, this.comment, this.email});
}
