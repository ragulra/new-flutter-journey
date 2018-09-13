import 'dart:math';
import 'package:flutter/material.dart';

import 'package:youtube_comment_section/app/comment.class.dart';
import 'package:youtube_comment_section/app/json_to_class.dart';

Random rand = Random();

int next(int min, int max) => min + rand.nextInt(max - min);

class HomePage extends StatefulWidget {
  final String data;

  HomePage({@required this.data});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController;
  List<Comment> commentsdata = <Comment>[];

  void _scrollToRandomPos() {
    scrollController.animateTo(
      next(0, commentsdata.length * 90).toDouble(),
      duration: Duration(milliseconds: 3000),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    loadComments(widget.data).then((data) {
      commentsdata = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
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
            child: FutureBuilder(
              future: loadComments(widget.data),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                        'Something wrong occured while fetching the data.'),
                  ));
                }

                return snapshot.hasData
                    ? ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return YoutubeCommentItem(
                            data: snapshot.data[index],
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ), // before it pass to YoutubeCommentItem class you need to make a future function to turn the data into a class
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed: () => _scrollToRandomPos(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class YoutubeCommentItem extends StatelessWidget {
  final int randomcolor;
  final int randomDays;
  final int randomThumbsUp;
  final int randomLikes;
  final int randomComments;
  final Comment data; //turn into a class first

  YoutubeCommentItem({@required this.data})
      : randomcolor = rand.nextInt(0xffffffff),
        randomDays = rand.nextInt(7),
        randomThumbsUp = rand.nextInt(1000),
        randomLikes = rand.nextInt(1000),
        randomComments = rand.nextInt(1000);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(randomcolor),
                child: Text(data.id.toString()), //should be random color
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.email +
                          ' * ' +
                          (randomDays == 0
                              ? 1.toString()
                              : randomDays.toString()) +
                          ' days ago',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      data.comment,
                      style: TextStyle(fontSize: 13.0),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            SizedBox(width: 5.0),
                            Text(
                              (randomThumbsUp == 0
                                  ? 1.toString()
                                  : randomThumbsUp.toString()),
                              style: TextStyle(fontSize: 12.0),
                            )
                          ],
                        ),
                        SizedBox(width: 25.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.thumb_down),
                            SizedBox(width: 5.0),
                            Text(
                              (randomLikes == 0
                                  ? 1.toString()
                                  : randomLikes.toString()),
                              style: TextStyle(fontSize: 12.0),
                            )
                          ],
                        ),
                        SizedBox(width: 25.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.comment),
                            SizedBox(width: 5.0),
                            Text(
                              (randomComments == 0
                                  ? 1.toString()
                                  : randomComments.toString()),
                              style: TextStyle(fontSize: 12.0),
                            )
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
