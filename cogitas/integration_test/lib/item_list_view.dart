import 'package:flutter/material.dart';
import 'package:integration_test/all_string.dart';

class ItemListView extends StatelessWidget {
  final List<String> items;
  final String typeId;

  ItemListView({Key key, this.items, this.typeId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (items != null) {
      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: items.map((String value) {
          return _singleItemDisplay(value, items.indexOf(value));
        }).toList(),
      );
    } else {
      return Text(EMPTY);
    }
  }

  Widget _singleItemDisplay(String item, int index) {
    return Container(
      key: Key(getStringKeyForListItem(typeId, index)),
      height: 40.0,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        color: Color(0x33000000),
        child: Text(item),
      ),
    );
  }
}