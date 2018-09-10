import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;

import 'package:keeper_of_the_image/app/images_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();

  File _image;

  List<IconData> icons = [Icons.photo_camera, Icons.photo_album];

  void showMessage(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  Future onPressed(IconData icon) async {
    if (controller.text != '') {
      if (icon == Icons.photo_camera) {
        var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

        final tmpDir = await getTemporaryDirectory();
        final path = tmpDir.path;

        String title = controller.text;

        Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
        Img.Image smallerImage = Img.copyResize(image, 500);

        var compressedImage = File("$path/image_$title.jpg")
          ..writeAsBytesSync(Img.encodeJpg(smallerImage, quality: 85));

        setState(() {
          _image = compressedImage;
        });
      } else if (icon == Icons.photo_album) {
        var imageFile =
            await ImagePicker.pickImage(source: ImageSource.gallery);

        final tmpDir = await getTemporaryDirectory();
        final path = tmpDir.path;

        String title = controller.text;

        Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
        Img.Image smallerImage = Img.copyResize(image, 500, 666);

        var compressedImage = File("$path/image_$title.jpg")
          ..writeAsBytesSync(Img.encodeJpg(smallerImage, quality: 85));

        setState(() {
          _image = compressedImage;
        });
      }
    } else {
      showMessage('Enter the image title first');
    }
  }

  Future _uploadImage(File imageFile) async {
    print(controller.text);
    if (imageFile != null && controller.text != '') {
      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var uri = Uri.parse('http://192.168.1.9/koti/uploader.php');

      var request = http.MultipartRequest('POST', uri);

      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path));

      request.fields['title'] = controller.text;
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        controller.clear();
        setState(() {
          _image = null;
        });
        showMessage('Image uploaded.');
      } else {
        showMessage('Upload image failed.');
      }
    } else {
      if (controller.text == '') {
        showMessage('Image title cannot be empty.');
      } else {
        showMessage('There is no image to send.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImagePage()
            )),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: icons.map(
                (icon) {
                  return ActionButton(
                    onPressed: () => onPressed(icon),
                    icon: icon,
                    text: icon == Icons.photo_camera ? 'Camera' : 'Gallery',
                    splash: icon == Icons.photo_camera
                        ? Colors.yellow
                        : Colors.green,
                    color: icon == Icons.photo_camera
                        ? Colors.orange
                        : Colors.blue,
                  );
                },
              ).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    hintText: 'Image title...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    )),
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Center(
                child: _image == null
                    ? Text('There is no image selected.')
                    : Image.file(_image),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed: () => _uploadImage(_image),
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;
  final Color color;
  final Color splash;

  ActionButton({
    @required this.icon,
    @required this.text,
    @required this.onPressed,
    @required this.color,
    @required this.splash,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      highlightElevation: 0.0,
      elevation: 0.0,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      color: color,
      splashColor: splash,
    );
  }
}
