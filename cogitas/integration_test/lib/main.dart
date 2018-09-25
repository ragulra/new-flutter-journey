import 'package:flutter/material.dart';

import 'package:integration_test/all_string.dart';
import 'package:integration_test/item_list_view.dart';
import 'package:integration_test/selected_item_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Integration Test',
    theme: ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.tealAccent,
    ),
    home: ListPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<String> _stores;
  List<String> _products;
  List<String> _selectedItems;

  String _selectedType;

  Widget buttonsWidget() {
    return SelectListView(
      showProducts: _showProducts,
      showStores: _showStores,
    );
  }

  Widget itemsWidget() {
    return ItemListView(
      typeId: _selectedType,
      items: _selectedItems,
    );
  }

  void _showProducts() {
    setState(() {
      _selectedItems = _products;
      _selectedType = PRODUCT_TYPE;
    });
  }

  void _showStores() {
    setState(() {
      _selectedItems = _stores;
      _selectedType = STORE_TYPE;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedItems = null;
    _selectedType = '';

    _stores = List<String>();
    _stores.add('London');
    _stores.add('Paris');
    _stores.add('Atlanta');

    _products = List<String>();
    _products.add('Laptop');
    _products.add('Monitor');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('List of Items'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: Column(
          children: <Widget>[
            buttonsWidget(),
            Expanded(
              child: itemsWidget(),
            )
          ],
        ),
      ),
    );
  }
}
