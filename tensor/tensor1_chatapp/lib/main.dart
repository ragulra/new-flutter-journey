import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey,
  primaryColorBrightness: Brightness.dark
);

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.greenAccent
);

const String defaultUsername = 'rasyidcode';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        title: 'Chat Application',
        theme: defaultTargetPlatform == TargetPlatform.iOS
          ? iOSTheme
          : androidTheme,
        home: new Chat(),
      );
    }
}

class Chat extends StatefulWidget {
  @override
    State createState() => new ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin { /* enable user to scroll like 
    ticker whenever user input a message */
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textEditingController = new TextEditingController();
  bool _isWriting = false;

  void _submitMsg(String text) {
    _textEditingController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      text: text,
      animationController: new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 800)
      ),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(
        color: Theme.of(context).accentColor
      ),
      child: new Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS
        ? new BoxDecoration(
          border: new Border(top: new BorderSide(color: Colors.brown))
        ) : null,
        margin: const EdgeInsets.symmetric(horizontal: 9.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textEditingController,
                onChanged: (String text) {
                  setState(() {
                    _isWriting = text.length > 0;
                  });
                },
                onSubmitted: _submitMsg,
                decoration: new InputDecoration.collapsed(
                  hintText: "Enter some text to send a message"
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 3.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                ? new CupertinoButton(
                  child: new Text('Submit'),
                  onPressed: _isWriting ? () => _submitMsg(_textEditingController.text) : null
                )
                : new IconButton(
                  icon: new Icon(Icons.message),
                  onPressed: _isWriting ? () => _submitMsg(_textEditingController.text) : null,
                )
            )
          ],
        ),
      ),
    );
  }

  @override
    void dispose() {
      // TODO: implement dispose
      for(Msg msg in _messages) {
        msg.animationController.dispose();
      }
      super.dispose();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Chat Application'),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
        ),
        body: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
                reverse: true,
                padding: new EdgeInsets.all(6.0),
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              child: _buildComposer(),
              decoration: new BoxDecoration(
                color: Theme.of(context).cardColor
              ),
            )
          ],
        ),
      );
    }
}

class Msg extends StatelessWidget {
  final String text;
  final AnimationController animationController;

  Msg({this.text, this.animationController});

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new SizeTransition(
        sizeFactor: new CurvedAnimation(
          parent: animationController,
          curve: Curves.bounceOut
        ),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 18.0),
                child: new CircleAvatar(child: new Text(defaultUsername[0])),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(defaultUsername, style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: new Text(text),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
}