import 'package:flutter/material.dart';
import 'package:integration_test/all_string.dart';

class SelectListView extends StatelessWidget {
  final Function showProducts;
  final Function showStores;

  SelectListView({
    Key key,
    this.showProducts,
    this.showStores,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            textColor: Colors.blueGrey,
            color: Colors.white,
            child: Text(SHOW_STORES),
            onPressed: showStores,
          ),
          FlatButton(
            textColor: Colors.blueGrey,
            color: Colors.white,
            child: Text(SHOW_PRODUCTS),
            onPressed: showProducts,
          )
        ],
      ),
    );
  }
}