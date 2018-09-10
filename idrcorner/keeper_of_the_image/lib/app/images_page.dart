import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

const BASE_URL_IMAGE = 'http://192.168.1.9/koti/images/';

class ImagePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List> _getImages() async {
    var res = await http.get('http://192.168.1.9/koti/get_images.php');

    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Image on Server'),
      ),
      body: FutureBuilder(
        future: _getImages(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Something wrong occured.'),
              ),
            );
          }

          return snapshot.hasData
              ? ImageServerList(data: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ImageServerList extends StatelessWidget {
  final List data;

  ImageServerList({@required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7
      ),
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(
              BASE_URL_IMAGE + data[index]['image'],
            ),
            Text(data[index]['title'])
          ],
        );
      },
      itemCount: data.length == 0 ? 0 : data.length,
    );
  }
}
