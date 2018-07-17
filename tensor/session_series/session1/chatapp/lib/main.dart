import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final ThemeData iOSTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[400],
  primaryColorBrightness: Brightness.dark
);

final ThemeData androidTheme = ThemeData(
  primarySwatch: Colors.indigo,
  accentColor: Colors.green[100]
);

const String defaultUserName = 'Jamil Al Rasyid';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'ChatNow',
        theme: defaultTargetPlatform == TargetPlatform.iOS ? iOSTheme : androidTheme,
        home: Chat(),
      );
    }
}

class Chat extends StatefulWidget {
  @override
    _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {
  final List<Message> _messages = <Message>[];
  final TextEditingController _textController = TextEditingController();
  bool _isWriting = false;

  void _submitMessage(String text) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Message message = Message(
      text: text,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800)
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildComposer() {
      return IconTheme(
        data: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 9.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onChanged: (String txt) {
                    setState(() {
                      _isWriting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMessage,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter a message...'
                  ),
                ),
              ),
              Container(
                decoration: Theme.of(context).platform == TargetPlatform.iOS ?
                  BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.brown[200]))
                  ) : null,
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                child: Theme.of(context).platform == TargetPlatform.iOS ?
                  CupertinoButton(
                    child: Text('Submit'),
                    onPressed: _isWriting ? () => _submitMessage(_textController.text) : null) 
                  :
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: _isWriting ? () => _submitMessage(_textController.text) : null)
              )
            ],
          ),
        ),
      );
    }

  @override
    void dispose() {
      // TODO: implement dispose
      for(Message message in _messages) {
        message.animationController.dispose();
      }
      super.dispose();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('ChatNow'),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
                reverse: true,
                padding: EdgeInsets.all(6.0),
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor
              ),
              child: _buildComposer(),
            )
          ],
        ),
      );
    }
}

class Message extends StatelessWidget {
  final String text;
  final AnimationController animationController;

  Message({this.text, this.animationController});

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.bounceOut
        ),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 18.0),
                child: CircleAvatar(
                  child: Text(
                    defaultUserName[0]
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(defaultUserName, style: Theme.of(context).textTheme.subhead),
                    Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: Text(text),
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